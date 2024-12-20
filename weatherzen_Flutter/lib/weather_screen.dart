import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weatherzen/aboutus_screen.dart';
import 'package:weatherzen/home_screen.dart';
import 'package:weatherzen/services_screen.dart';
import 'package:weatherzen/weather_chart.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class WeatherData {
  final double waterLevel;
  final DateTime date;
  final String riskStatus;
  WeatherData(
      {required this.waterLevel, required this.date, required this.riskStatus});
}

class WeatherService {
  final String apiKey;
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  WeatherService({required this.apiKey});

  Future<double> getAverageRainForToday(double lat, double lon) async {
    final url =
        Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List forecasts = data['list'];
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      double totalRain = 0.0;
      int count = 0;

      for (var forecast in forecasts) {
        String forecastDate = forecast['dt_txt'].split(' ')[0];
        if (forecastDate == today) {
          double rainVolume = forecast['rain']?['3h'] ?? 0.0;
          totalRain += rainVolume;
          count++;
        }
      }

      if (count == 0) return 0.0;
      return totalRain / count;
    } else {
      throw Exception('Failed to fetch rain data');
    }
  }
}

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
  required String riskStatus,
  required String station,
}) async {
  final CollectionReference weatherCollection =
      FirebaseFirestore.instance.collection('WeatherZen');

  try {
    await weatherCollection.add({
      'Water level': waterLevel,
      'Rainfall': rainfall,
      'Date': date,
      'Risk status': riskStatus,
      'Station': station,
    });
    print('Data successfully added to Firebase!');
  } catch (e) {
    print('Error adding data to Firebase: $e');
  }
}

class FloodPrediction extends StatefulWidget {
  @override
  _FloodPredictionState createState() => _FloodPredictionState();
}

class _FloodPredictionState extends State<FloodPrediction> {
  String selectedLocation = ''; // Default location
  double averageRain = 0.0;
  String averageRaindecimal = '';
  double waterlevel = 0.0;
  String predictedLevel1hrAgo = '';
  String predictedLevel1hrAfter = '';
  String riskStatus = '';
  final String apiKey = 'c8eaccaaf2ba8a4c198083a8af5089ba';
  //apiKey = '2838b9413461d2f9755a36de24de2732';
  //alternative KEY(c8eaccaaf2ba8a4c198083a8af5089ba)
  final String flaskUrl = 'http://127.0.0.2:8000/predict';

  // List of locations with their lat/lon
  final Map<String, Map<String, double>> locations = {
    "N' Street": {'lat': 6.955427423266254, 'lon': 79.87651509999999},
    'Baddegama': {'lat': 6.173611111111112, 'lon': 80.17586111111112},
    'Hanwella': {'lat': 6.910938888888889, 'lon': 80.0842111111111},
    'Glencourse': {'lat': 6.973611111111111, 'lon': 80.18416666666667},
    'Kitulgala': {'lat': 6.990277777777778, 'lon': 80.41388888888889},
    'Holombuwa': {'lat': 7.1851666666666665, 'lon': 80.26480555555555},
    'Deraniyagala': {'lat': 6.923119444444445, 'lon': 80.33897222222221},
    'Norwood': {'lat': 6.835644444444444, 'lon': 80.61465277777778},
    'Putupaula': {'lat': 6.614416666666666, 'lon': 80.06227777777778},
    'Ellagawa': {'lat': 6.7316666666666665, 'lon': 80.21783333333333},
    'Rathnapura': {'lat': 6.6786666666666665, 'lon': 80.39716666666668},
    'Magura': {'lat': 6.5136111111111115, 'lon': 80.24333333333334},
    'Kalawellawa': {'lat': 6.630638888888889, 'lon': 80.16047222222223},
    'Thawalama': {'lat': 6.342583333333333, 'lon': 80.332},
    'Thalgahagoda': {'lat': 6.011111111111111, 'lon': 80.52638888888889},
    'Panadugama': {'lat': 6.133333333333334, 'lon': 80.48333333333333},
    'Pitabeddara': {'lat': 6.213388888888889, 'lon': 80.47625000000001},
    'Urawa': {'lat': 6.236611111111111, 'lon': 80.57166666666666},
    'Moraketiya': {'lat': 6.345277777777778, 'lon': 80.90138888888889},
    'Thanamalwila': {'lat': 6.468305555555555, 'lon': 81.13411111111112},
    'Wellawaya': {'lat': 6.70925, 'lon': 81.11155555555555},
    'Kuda Oya': {'lat': 6.524666666666667, 'lon': 81.12333333333332},
    'Katharagama': {'lat': 6.416666666666667, 'lon': 81.3325},
    'Nakkala': {'lat': 6.8951111111111105, 'lon': 81.29702777777777},
    'Siyambalanduwa': {'lat': 6.904583333333334, 'lon': 81.54566666666666},
    'Padiyathalawa': {'lat': 7.383333333333334, 'lon': 81.19166666666668},
    'Manampitiya(Old)': {'lat': 7.914805555555556, 'lon': 81.08611111111111},
    'Manampitiya(HMIS)': {'lat': 7.914805555555556, 'lon': 81.08611111111111},
    'Weraganthota': {'lat': 7.316666666666666, 'lon': 80.98841666666667},
    'Peradeniya': {'lat': 7.2675, 'lon': 80.60833333333333},
    'Nawalapitiya': {'lat': 7.048611111111111, 'lon': 80.53416666666666},
    'Thaldena': {'lat': 7.09075, 'lon': 81.04813888888889},
    'Calidonia': {'lat': 6.9023055555555555, 'lon': 80.7},
    'Horowpathana': {'lat': 8.577622222222223, 'lon': 80.87868055555555},
    'Yaka Wewa': {'lat': 8.721944444444444, 'lon': 80.68055555555556},
    'Thanthirimale': {'lat': 8.587102777777778, 'lon': 80.27531666666667},
    'Galgamuwa': {'lat': 7.970361111111111, 'lon': 80.25508333333333},
    'Deduru Oya': {'lat': 7.726666666666667, 'lon': 80.26333333333334},
    'Badalgama': {'lat': 7.300916666666667, 'lon': 79.98055555555555},
    'Giriulla': {'lat': 7.325, 'lon': 80.11480555555555},
    'Dunamale': {'lat': 7.116666666666666, 'lon': 80.08180555555555}
  };

  void _submitForm(
      double waterlevel, double avgrain, String risk, String station) {
    print('Average rain: $avgrain, Station: $station'); // Debugging output

    if (station.isNotEmpty) {
      // Ensure that the station is selected
      addWeatherData(
        waterLevel: waterlevel,
        rainfall: avgrain,
        date: DateTime.now(),
        riskStatus: risk,
        station: station,
      ).then((_) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Weather data submitted successfully!')),
        // );
      }).catchError((error) {
        print('Error occurred: $error'); // Debugging any errors
      });
    } else {
      print('Station not selected, cannot submit data.');
    }
  }

  Future<void> fetchRainData(double lat, double lon) async {
    final String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
    final url =
        Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List forecasts = data['list'];
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      double totalRain = 0.0;
      int count = 0;
      for (var forecast in forecasts) {
        String forecastDate = forecast['dt_txt'].split(' ')[0];
        if (forecastDate == today) {
          double rainVolume = forecast['rain']?['3h'] ?? 0.0;
          totalRain += rainVolume;
          count++;
        }
      }
      setState(() {
        averageRain =
            count == 0 ? 0.0 : totalRain / count; // Correctly handle average
        averageRaindecimal = averageRain.toStringAsFixed(2);
      });
    } else {
      throw Exception('Failed to fetch rain data');
    }
  }

  Future<void> getPrediction(String region, double rainfall) async {
    final response = await http.post(
      Uri.parse(flaskUrl),
      body: {
        'region': region,
        'rainfall': rainfall.toString(),
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        //predictedLevel1hrAgo = result['predicted_level_1hr_ago'].toString();
        double predictedLevel1hrAgoDouble =
            double.parse(result['predicted_level_1hr_ago'].toString());
        predictedLevel1hrAgo = predictedLevel1hrAgoDouble.toStringAsFixed(2);

        //predictedLevel1hrAfter = result['predicted_level_1hr_after'].toString();
        double predictedLevel1hrAfterDouble =
            double.parse(result['predicted_level_1hr_after'].toString());
        predictedLevel1hrAfter =
            predictedLevel1hrAfterDouble.toStringAsFixed(2);
        waterlevel = predictedLevel1hrAfterDouble;
        riskStatus = result['risk_status'];
        print(
          region,
        );
        print(riskStatus);
        print(rainfall);
        _submitForm(result['predicted_level_1hr_after'], rainfall,
            result['risk_status'], region);
      });
    } else {
      throw Exception('Failed to get prediction');
    }
  }

  Color getRiskColor(String riskStatus) {
    switch (riskStatus) {
      case 'Normal':
        return Colors.green;
      case 'Alert':
        return Colors.yellow;
      case 'Minor Flood':
        return Colors.orange;
      case 'Major Flood':
        return Colors.red;
      default:
        return const Color.fromARGB(0, 158, 158, 158);
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
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: const Text("Home",
                      style: TextStyle(color: Color(0xFF221543))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ServicesScreen()),
                    );
                  },
                  child: const Text("Services",
                      style: TextStyle(color: Color(0xFF221543))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutusScreen()),
                    );
                  },
                  child: const Text("About Us",
                      style: TextStyle(color: Color(0xFF221543))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Text(
                      "Hello, Danushka",
                      style: TextStyle(color: Color(0xFF221543), fontSize: 15),
                    ),
                  ),
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/moon_wind.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 30),
                  Image.asset(
                    'assets/moon_rain.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 30),
                  Image.asset(
                    'assets/Sun_rain.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 30),
                  Image.asset(
                    'assets/Sun_mid_rain.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 30),
                  Image.asset(
                    'assets/Tornado.png',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Check Flood Risk",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: 800,
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value:
                            selectedLocation.isEmpty ? null : selectedLocation,
                        hint: Text('Select your closest gauging station'),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLocation = newValue!;
                          });
                        },
                        items: locations.keys
                            .map<DropdownMenuItem<String>>((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        isExpanded:
                            true, // To make sure the dropdown fills the container
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  backgroundColor: const Color.fromARGB(155, 9, 4, 24),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () async {
                  var lat = locations[selectedLocation]!['lat']!;
                  var lon = locations[selectedLocation]!['lon']!;
                  // _submitForm(
                  //     waterlevel, averageRain, riskStatus, selectedLocation);
                  await fetchRainData(lat, lon);
                  await getPrediction(selectedLocation, averageRain);
                },
                child: Text(
                  'Get Prediction',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WeatherChartScreen()),
                  );
                },
                child: const Text("History Data",
                    style: TextStyle(
                      color: Color.fromARGB(150, 255, 255, 255),
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 400,
                        padding: const EdgeInsets.only(
                          left: 130,
                          right: 130,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 217, 217, 217),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Results:',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            if (averageRain != null &&
                                predictedLevel1hrAgo != null &&
                                predictedLevel1hrAfter != null &&
                                riskStatus != null) ...[
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Average Rainfall (mm):',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('$averageRaindecimal',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: const Color.fromARGB(
                                            255, 78, 196, 0),
                                      ),
                                      textAlign: TextAlign.right),
                                ],
                              ),
                              Divider(),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Predicted Level 1 Hour Ago (m) :',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('$predictedLevel1hrAgo',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: const Color.fromARGB(
                                            255, 78, 196, 0),
                                      ),
                                      textAlign: TextAlign.right),
                                ],
                              ),
                              Divider(),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Predicted Level 1 Hour After (m) :',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('$predictedLevel1hrAfter',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: const Color.fromARGB(
                                            255, 78, 196, 0),
                                      ),
                                      textAlign: TextAlign.right),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Flood Risk Status:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: getRiskColor(
                                          riskStatus), // Color based on status
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      riskStatus,
                                      style: TextStyle(
                                        color: Colors.white, // Text color
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildColoredCircleWithLabel(
                                        Colors.green, "Normal"),
                                    SizedBox(
                                        width: 20), // Spacing between items
                                    _buildColoredCircleWithLabel(
                                        Colors.yellow, "Alert"),
                                    SizedBox(width: 20),
                                    _buildColoredCircleWithLabel(
                                        Colors.orange, "Minor Flood"),
                                    SizedBox(width: 20),
                                    _buildColoredCircleWithLabel(
                                        Colors.red, "Major Flood"),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
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

  Widget _buildColoredCircleWithLabel(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 10),
        Text(label),
      ],
    );
  }
}







// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:weatherzen/aboutus_screen.dart';
// import 'package:weatherzen/home_screen.dart';
// import 'package:weatherzen/services_screen.dart';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (kIsWeb) {
//     // Provide the web Firebase options
//     await Firebase.initializeApp(
//       options: FirebaseOptions(
//         apiKey: "AIzaSyBACWgZ77NPd7aWyBlzmX7OEGt6tx-SZjw",
//         authDomain: "weatherzen-c87f6.firebaseapp.com",
//         projectId: "weatherzen-c87f6",
//         storageBucket: "weatherzen-c87f6.appspot.com",
//         messagingSenderId: "292375270014",
//         appId: "1:292375270014:web:a7ec0993a56beacaeefe2f",
//         measurementId: "G-57Y855L39K",
//       ),
//     );
//     print("Successfull");
//   } else {
//     // Use default initialization for mobile (Firebase options are handled internally)
//     await Firebase.initializeApp();
//   }

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weather Data Input',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FloodPrediction(),
//     );
//   }
// }

// class WeatherData {
//   final double waterLevel;
//   final DateTime date;
//   final String riskStatus;

//   WeatherData(
//       {required this.waterLevel, required this.date, required this.riskStatus});
// }

// class WeatherService {
//   final String apiKey;
//   final String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

//   WeatherService({required this.apiKey});

//   Future<double> getAverageRainForToday(double lat, double lon) async {
//     final url =
//         Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       List forecasts = data['list'];
//       String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

//       double totalRain = 0.0;
//       int count = 0;

//       for (var forecast in forecasts) {
//         String forecastDate = forecast['dt_txt'].split(' ')[0];
//         if (forecastDate == today) {
//           double rainVolume = forecast['rain']?['3h'] ?? 0.0;
//           totalRain += rainVolume;
//           count++;
//         }
//       }

//       if (count == 0) return 0.0;
//       return totalRain / count;
//     } else {
//       throw Exception('Failed to fetch rain data');
//     }
//   }
// }

// Future<void> addWeatherDocument(Map<String, dynamic> weatherData) async {
//   try {
//     await _firestore.collection('WeatherZen').add(weatherData);

//     print('Weather document added successfully!');
//   } catch (e) {
//     print('Error adding weather document: $e');
//   }
// }

// Future<void> addWeatherData({
//   required double waterLevel,
//   required double rainfall,
//   required DateTime date,
//   required String riskStatus,
//   required String station,
// }) async {
//   // Prepare the data as a map
//   Map<String, dynamic> weatherData = {
//     'Water level': waterLevel,
//     'Rainfall': rainfall,
//     'Date': Timestamp.fromDate(date),
//     'Risk status': riskStatus,
//     'Station': station,
//   };
//   await addWeatherDocument(weatherData);
// }

// class FloodPrediction extends StatefulWidget {
//   @override
//   _FloodPredictionState createState() => _FloodPredictionState();
// }

// class _FloodPredictionState extends State<FloodPrediction> {
//   final _formKey = GlobalKey<FormState>();
//   String selectedLocation = 'Rathnapura';
//   double averageRain = 0.0;
//   String averageRaindecimal = '';
//   String predictedLevel1hrAgo = '';
//   String predictedLevel1hrAfter = '';
//   double waterlevel = 0.0;
//   String riskStatus = 'Normal';
//   final String apiKey = '2838b9413461d2f9755a36de24de2732';
//   //alternative KEY(c8eaccaaf2ba8a4c198083a8af5089ba)
//   final String flaskUrl = 'http://127.0.0.2:8000/predict';

//   // List of locations with their lat/lon
//   final Map<String, Map<String, double>> locations = {
//     "N' Street": {'lat': 6.955427423266254, 'lon': 79.87651509999999},
//     'Baddegama': {'lat': 6.173611111111112, 'lon': 80.17586111111112},
//     'Hanwella': {'lat': 6.910938888888889, 'lon': 80.0842111111111},
//     'Glencourse': {'lat': 6.973611111111111, 'lon': 80.18416666666667},
//     'Kitulgala': {'lat': 6.990277777777778, 'lon': 80.41388888888889},
//     'Holombuwa': {'lat': 7.1851666666666665, 'lon': 80.26480555555555},
//     'Deraniyagala': {'lat': 6.923119444444445, 'lon': 80.33897222222221},
//     'Norwood': {'lat': 6.835644444444444, 'lon': 80.61465277777778},
//     'Putupaula': {'lat': 6.614416666666666, 'lon': 80.06227777777778},
//     'Ellagawa': {'lat': 6.7316666666666665, 'lon': 80.21783333333333},
//     'Rathnapura': {'lat': 6.6786666666666665, 'lon': 80.39716666666668},
//     'Magura': {'lat': 6.5136111111111115, 'lon': 80.24333333333334},
//     'Kalawellawa': {'lat': 6.630638888888889, 'lon': 80.16047222222223},
//     'Thawalama': {'lat': 6.342583333333333, 'lon': 80.332},
//     'Thalgahagoda': {'lat': 6.011111111111111, 'lon': 80.52638888888889},
//     'Panadugama': {'lat': 6.133333333333334, 'lon': 80.48333333333333},
//     'Pitabeddara': {'lat': 6.213388888888889, 'lon': 80.47625000000001},
//     'Urawa': {'lat': 6.236611111111111, 'lon': 80.57166666666666},
//     'Moraketiya': {'lat': 6.345277777777778, 'lon': 80.90138888888889},
//     'Thanamalwila': {'lat': 6.468305555555555, 'lon': 81.13411111111112},
//     'Wellawaya': {'lat': 6.70925, 'lon': 81.11155555555555},
//     'Kuda Oya': {'lat': 6.524666666666667, 'lon': 81.12333333333332},
//     'Katharagama': {'lat': 6.416666666666667, 'lon': 81.3325},
//     'Nakkala': {'lat': 6.8951111111111105, 'lon': 81.29702777777777},
//     'Siyambalanduwa': {'lat': 6.904583333333334, 'lon': 81.54566666666666},
//     'Padiyathalawa': {'lat': 7.383333333333334, 'lon': 81.19166666666668},
//     'Manampitiya(Old)': {'lat': 7.914805555555556, 'lon': 81.08611111111111},
//     'Manampitiya(HMIS)': {'lat': 7.914805555555556, 'lon': 81.08611111111111},
//     'Weraganthota': {'lat': 7.316666666666666, 'lon': 80.98841666666667},
//     'Peradeniya': {'lat': 7.2675, 'lon': 80.60833333333333},
//     'Nawalapitiya': {'lat': 7.048611111111111, 'lon': 80.53416666666666},
//     'Thaldena': {'lat': 7.09075, 'lon': 81.04813888888889},
//     'Calidonia': {'lat': 6.9023055555555555, 'lon': 80.7},
//     'Horowpathana': {'lat': 8.577622222222223, 'lon': 80.87868055555555},
//     'Yaka Wewa': {'lat': 8.721944444444444, 'lon': 80.68055555555556},
//     'Thanthirimale': {'lat': 8.587102777777778, 'lon': 80.27531666666667},
//     'Galgamuwa': {'lat': 7.970361111111111, 'lon': 80.25508333333333},
//     'Deduru Oya': {'lat': 7.726666666666667, 'lon': 80.26333333333334},
//     'Badalgama': {'lat': 7.300916666666667, 'lon': 79.98055555555555},
//     'Giriulla': {'lat': 7.325, 'lon': 80.11480555555555},
//     'Dunamale': {'lat': 7.116666666666666, 'lon': 80.08180555555555}
//   };
  // void _submitForm(
  //     double waterlevel, double avgrain, String risk, String station) {
  //   print('avergae rain:$avgrain, Station:$station');
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     if (selectedLocation != null) {
  //       addWeatherData(
  //         waterLevel: waterlevel,
  //         rainfall: avgrain,
  //         date: DateTime.now(),
  //         riskStatus: risk,
  //         station: station,
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Weather data submitted successfully!'),
  //         ),
  //       );
  //     }
  //   }
  // }

//   Future<void> fetchRainData(double lat, double lon) async {
//     final String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
//     final url =
//         Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       List forecasts = data['list'];
//       String today = DateTime.now().toString().split(' ')[0];

//       double totalRain = 0.0;
//       int count = 0;
//       for (var forecast in forecasts) {
//         String forecastDate = forecast['dt_txt'].split(' ')[0];
//         if (forecastDate == today) {
//           double rainVolume = forecast['rain']?['3h'] ?? 0.0;
//           totalRain += rainVolume;
//           count++;
//         }
//       }
//       setState(() {
//         averageRain = count == 0 ? 0.0 : totalRain / (count - 1);
//         averageRaindecimal = averageRain.toStringAsFixed(2);
//       });
//     } else {
//       throw Exception('Failed to fetch rain data');
//     }
//   }

//   Future<void> getPrediction(String region, double rainfall) async {
//     final response = await http.post(
//       Uri.parse(flaskUrl),
//       body: {
//         'region': region,
//         'rainfall': rainfall.toString(),
//       },
//     );

//     if (response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       setState(() {
//         //predictedLevel1hrAgo = result['predicted_level_1hr_ago'].toString();
//         double predictedLevel1hrAgoDouble =
//             double.parse(result['predicted_level_1hr_ago'].toString());
//         predictedLevel1hrAgo = predictedLevel1hrAgoDouble.toStringAsFixed(2);

//         //predictedLevel1hrAfter = result['predicted_level_1hr_after'].toString();
//         double predictedLevel1hrAfterDouble =
//             double.parse(result['predicted_level_1hr_after'].toString());
//         predictedLevel1hrAfter =
//             predictedLevel1hrAfterDouble.toStringAsFixed(2);
//         waterlevel = predictedLevel1hrAfterDouble;
//         riskStatus = result['risk_status'];
//       });
//     } else {
//       throw Exception('Failed to get prediction');
//     }
//   }

//   Color getRiskColor(String riskStatus) {
//     switch (riskStatus) {
//       case 'Normal':
//         return Colors.green;
//       case 'Alert':
//         return Colors.yellow;
//       case 'Minor Flood':
//         return Colors.orange;
//       case 'Major Flood':
//         return Colors.red;
//       default:
//         return const Color.fromARGB(0, 158, 158, 158);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xFF6e6d90),
//         elevation: 0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 // Add your logo here
//                 Image.asset('assets/weat_logo.png', height: 40),
//                 const SizedBox(width: 1),
//                 const Text(
//                   "WeatherZen",
//                   style: TextStyle(color: Color(0xFF221543), fontSize: 15),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()),
//                     );
//                   },
//                   child: const Text("Home",
//                       style: TextStyle(color: Color(0xFF221543))),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ServicesScreen()),
//                     );
//                   },
//                   child: const Text("Services",
//                       style: TextStyle(color: Color(0xFF221543))),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AboutusScreen()),
//                     );
//                   },
//                   child: const Text("About Us",
//                       style: TextStyle(color: Color(0xFF221543))),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Container(
//                     child: Text(
//                       "Hello, Danushka",
//                       style: TextStyle(color: Color(0xFF221543), fontSize: 15),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             colors: [Color(0xFF45278B), Color(0xFF2E335A)],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//           child: Column(
//             children: [
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.end,
//               //   children: [
//               //     Image.asset(
//               //       'assets/moon_wind.png',
//               //       width: 30,
//               //       height: 30,
//               //     ),
//               //     SizedBox(width: 30),
//               //     Image.asset(
//               //       'assets/moon_rain.png',
//               //       width: 30,
//               //       height: 30,
//               //     ),
//               //     SizedBox(width: 30),
//               //     Image.asset(
//               //       'assets/Sun_rain.png',
//               //       width: 30,
//               //       height: 30,
//               //     ),
//               //     SizedBox(width: 30),
//               //     Image.asset(
//               //       'assets/Sun_mid_rain.png',
//               //       width: 30,
//               //       height: 30,
//               //     ),
//               //     SizedBox(width: 30),
//               //     Image.asset(
//               //       'assets/Tornado.png',
//               //       width: 30,
//               //       height: 30,
//               //     ),
//               //   ],
//               // ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Check Flood Risk",
//                     style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 80),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(25.0),
//                       border: Border.all(color: Colors.grey),
//                     ),
//                     width: 800,
//                     height: 50,
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: selectedLocation,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedLocation = newValue!;
//                           });
//                         },
//                         items: locations.keys
//                             .map<DropdownMenuItem<String>>((String location) {
//                           return DropdownMenuItem<String>(
//                             value: location,
//                             child: Text(location),
//                           );
//                         }).toList(),
//                         isExpanded:
//                             true, // To make sure the dropdown fills the container
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(100, 50),
//                   backgroundColor: const Color.fromARGB(155, 9, 4, 24),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 onPressed: () async {
//                   var lat = locations[selectedLocation]!['lat']!;
//                   var lon = locations[selectedLocation]!['lon']!;
//                   await fetchRainData(lat, lon);
//                   await getPrediction(selectedLocation, averageRain);
//                   _submitForm(
//                       waterlevel, averageRain, riskStatus, selectedLocation);
//                 },
//                 child: Text(
//                   'Get Prediction',
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 200,
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: 100,
//                         height: 400,
//                         padding: const EdgeInsets.only(
//                           left: 130,
//                           right: 130,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(20, 217, 217, 217),
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Results:',
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             if (averageRain != null &&
//                                 predictedLevel1hrAgo != null &&
//                                 predictedLevel1hrAfter != null &&
//                                 riskStatus != null) ...[
//                               SizedBox(height: 20),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Average Rainfall (mm):',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Text('$averageRaindecimal',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: const Color.fromARGB(
//                                             255, 78, 196, 0),
//                                       ),
//                                       textAlign: TextAlign.right),
//                                 ],
//                               ),
//                               Divider(),
//                               SizedBox(height: 5),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Predicted Level 1 Hour Ago (m) :',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Text('$predictedLevel1hrAgo',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: const Color.fromARGB(
//                                             255, 78, 196, 0),
//                                       ),
//                                       textAlign: TextAlign.right),
//                                 ],
//                               ),
//                               Divider(),
//                               SizedBox(height: 5),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Predicted Level 1 Hour After (m) :',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Text('$predictedLevel1hrAfter',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: const Color.fromARGB(
//                                             255, 78, 196, 0),
//                                       ),
//                                       textAlign: TextAlign.right),
//                                 ],
//                               ),
//                               SizedBox(height: 5),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Flood Risk Status:',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 5),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 8),
//                                     decoration: BoxDecoration(
//                                       color: getRiskColor(
//                                           riskStatus), // Color based on status
//                                       borderRadius: BorderRadius.circular(8.0),
//                                     ),
//                                     child: Text(
//                                       riskStatus,
//                                       style: TextStyle(
//                                         color: Colors.white, // Text color
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 35,
//                               ),
//                               Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     _buildColoredCircleWithLabel(
//                                         Colors.green, "Normal"),
//                                     SizedBox(
//                                         width: 20), // Spacing between items
//                                     _buildColoredCircleWithLabel(
//                                         Colors.yellow, "Alert"),
//                                     SizedBox(width: 20),
//                                     _buildColoredCircleWithLabel(
//                                         Colors.orange, "Minor Flood"),
//                                     SizedBox(width: 20),
//                                     _buildColoredCircleWithLabel(
//                                         Colors.red, "Major Flood"),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 200,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildColoredCircleWithLabel(Color color, String label) {
//     return Row(
//       children: [
//         Container(
//           width: 15,
//           height: 15,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color,
//           ),
//         ),
//         SizedBox(width: 10),
//         Text(label),
//       ],
//     );
//   }
// }
