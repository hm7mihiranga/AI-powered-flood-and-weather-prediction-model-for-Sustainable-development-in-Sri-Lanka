import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addWeatherDocument(Map<String, dynamic> weatherData) async {
  try {
    await _firestore.collection('WeatherZen').add(weatherData);
    print('Weather document added successfully!');
  } catch (e) {
    print('Error adding weather document: $e');
  }
}

Future<void> addWeatherData({
  required double waterLevel,
  required double rainfall,
  required DateTime date,
  required DateTime time,
  required String riskStatus,
  required String station,
}) async {
  Map<String, dynamic> weatherData = {
    'Water level': waterLevel,
    'Rainfall': rainfall,
    'Date': Timestamp.fromDate(date),
    'Time': Timestamp.fromDate(time),
    'Risk status': riskStatus,
    'Station': station,
  };
  await addWeatherDocument(weatherData);
}

class WeatherData {
  final double waterLevel;
  final DateTime date;
  final String riskStatus;

  WeatherData(
      {required this.waterLevel, required this.date, required this.riskStatus});
}

class WeatherChartScreen extends StatefulWidget {
  @override
  _WeatherChartScreenState createState() => _WeatherChartScreenState();
}

class _WeatherChartScreenState extends State<WeatherChartScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedStation;
  List<String> _stations = [
    "N' Street",
    'Hanwella',
    'Glencourse',
    'Kitulgala',
    'Holombuwa',
    'Deraniyagala',
    'Norwood',
    'Putupaula',
    'Ellagawa',
    'Rathnapura',
    'Magura',
    'Kalawellawa',
    'Thawalama',
    'Baddegama',
    'Thalgahagoda',
    'Panadugama',
    'Pitabeddara',
    'Urawa',
    'Moraketiya',
    'Thanamalwila',
    'Wellawaya',
    'Kuda Oya',
    'Katharagama',
    'Nakkala',
    'Siyambalanduwa',
    'Padiyathalawa',
    'Manampitiya (Old)',
    'Manampitiya (HMIS)',
    'Weraganthota',
    'Peradeniya',
    'Nawalapitiya',
    'Thaldena',
    'Calidonia',
    'Horowpathana',
    'Yaka Wewa',
    'Thantirimale',
    'Galgamuwa',
    'Ridi bendi Ella (Dam)',
    'Badalgama',
    'Moragaswewa',
    'Giriulla',
    'Dunamale'
  ]; // Example stations
  List<WeatherData> _weatherData = [];

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    if (_selectedStation == null) return;

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('WeatherZen')
          .where('Station', isEqualTo: _selectedStation)
          .get();

      _weatherData.clear();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        _weatherData.add(WeatherData(
          waterLevel: data['Water level']?.toDouble() ?? 0.0,
          date: (data['Date'] as Timestamp).toDate(),
          riskStatus: data['Risk status'] ?? 'Normal',
        ));
      }
      setState(() {});
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      addWeatherData(
        waterLevel: 10,
        rainfall: 5,
        date: DateTime.now(),
        time: DateTime.now(),
        riskStatus: 'Normal',
        station: _selectedStation!,
      );
      _fetchWeatherData();
    }
  }

  Color _getColorForRiskStatus(String status) {
    switch (status) {
      case 'Normal':
        return Colors.green;
      case 'Alert':
        return Colors.yellow;
      case 'Minor Flood':
        return Colors.orange;
      case 'Major Flood':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF6e6d90),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Add your logo here
                Image.asset('assets/weat_logo.png', height: 40),
                const SizedBox(width: 1),
                const Text(
                  "WeatherZen",
                  style: TextStyle(color: Color(0xFF221543), fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF45278B), Color(0xFF2E335A)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        width: 500,
                        height: 600,
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 217, 217, 217),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 14,
                              ),
                              Center(
                                child: Container(
                                  width: 800,
                                  height: 50,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          'Select Station to get history data',
                                    ),
                                    value: _selectedStation,
                                    items: _stations.map((String station) {
                                      return DropdownMenuItem<String>(
                                        value: station,
                                        child: Text(station),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedStation = newValue;
                                        _fetchWeatherData(); // Fetch data when a new station is selected
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a station';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildStatusLabel(Colors.green, "Normal"),
                                  SizedBox(width: 10),
                                  _buildStatusLabel(Colors.yellow, "Alert"),
                                  SizedBox(width: 10),
                                  _buildStatusLabel(
                                      Colors.orange, "Minor Flood"),
                                  SizedBox(width: 10),
                                  _buildStatusLabel(Colors.red, "Major Flood"),
                                ],
                              ),
                              SizedBox(height: 20),
                              _weatherData.isNotEmpty
                                  ? Expanded(
                                      child: SfCartesianChart(
                                        plotAreaBorderWidth:
                                            0, // Remove plot area border
                                        title: ChartTitle(
                                          text: 'Water Level Over Time',
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        primaryXAxis: DateTimeAxis(
                                          dateFormat: DateFormat('MM/dd HH:mm'),
                                          labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                          majorGridLines: MajorGridLines(
                                              width: 0), // Hide grid lines
                                        ),
                                        primaryYAxis: NumericAxis(
                                          labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                          maximum: 10,
                                          axisLine: AxisLine(width: 0),
                                          majorTickLines:
                                              MajorTickLines(size: 0),
                                        ),
                                        series: <CartesianSeries>[
                                          ColumnSeries<dynamic, DateTime>(
                                            dataSource:
                                                _weatherData, // Use your data list
                                            xValueMapper: (weather, _) => DateTime
                                                .fromMillisecondsSinceEpoch(weather
                                                    .date
                                                    .millisecondsSinceEpoch), // Mapping the date
                                            yValueMapper: (weather, _) =>
                                                weather
                                                    .waterLevel, // Water level
                                            pointColorMapper: (weather, _) =>
                                                _getColorForRiskStatus(weather
                                                    .riskStatus), // Risk color
                                            width: 0.6, // Bar width
                                            borderRadius: BorderRadius.circular(
                                                5), // Rounded corners
                                          ),
                                        ],
                                        tooltipBehavior: TooltipBehavior(
                                            enable: true), // Enable tooltips
                                      ),
                                    )
                                  : Text(
                                      'No data available for the selected station.',
                                      style: TextStyle(color: Colors.white),
                                    )
                              // _weatherData.isNotEmpty
                              //     ? Expanded(
                              //         child: BarChart(
                              //           BarChartData(
                              //             titlesData: FlTitlesData(
                              //               leftTitles: AxisTitles(
                              //                 sideTitles: SideTitles(
                              //                   showTitles: true,
                              //                   getTitlesWidget: (value, meta) {
                              //                     return Text(
                              //                       value.toString(),
                              //                       style: const TextStyle(
                              //                         fontSize: 10,
                              //                         color: Colors.white,
                              //                       ),
                              //                     );
                              //                   },
                              //                 ),
                              //               ),
                              //               bottomTitles: AxisTitles(
                              //                 sideTitles: SideTitles(
                              //                   showTitles: true,
                              //                   getTitlesWidget: (value, meta) {
                              //                     DateTime date = DateTime
                              //                         .fromMillisecondsSinceEpoch(
                              //                             value.toInt());
                              //                     return Text(
                              //                       DateFormat('MM/dd HH:mm')
                              //                           .format(date),
                              //                       style: const TextStyle(
                              //                         fontSize: 10,
                              //                         color: Colors.white,
                              //                       ),
                              //                     );
                              //                   },
                              //                 ),
                              //               ),
                              //               topTitles: AxisTitles(
                              //                 sideTitles:
                              //                     SideTitles(showTitles: false),
                              //               ),
                              //               rightTitles: AxisTitles(
                              //                 sideTitles:
                              //                     SideTitles(showTitles: false),
                              //               ),
                              //             ),
                              //             borderData: FlBorderData(show: true),
                              //             gridData: FlGridData(show: false),
                              //             barGroups:
                              //                 _weatherData.map((weather) {
                              //               return BarChartGroupData(
                              //                 x: weather
                              //                     .date.millisecondsSinceEpoch
                              //                     .toInt(),
                              //                 barRods: [
                              //                   BarChartRodData(
                              //                     toY: weather.waterLevel,
                              //                     color: _getColorForRiskStatus(
                              //                         weather.riskStatus),
                              //                     width: 20,
                              //                   ),
                              //                 ],
                              //               );
                              //             }).toList(),
                              //             maxY: 10,
                              //           ),
                              //         ),
                              //       )
                              //     : Text(
                              //         'No data available for the selected station.',
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //         )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatusLabel(Color color, String text) {
  return Row(
    children: [
      Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 5), // Space between circle and text
      Text(text,
          style: TextStyle(
            color: Colors.white,
          )),
    ],
  );
}
