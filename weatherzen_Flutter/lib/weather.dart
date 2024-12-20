import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RainDataScreen extends StatefulWidget {
  @override
  _RainDataScreenState createState() => _RainDataScreenState();
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

      // List of 3-hour forecasts
      List forecasts = data['list'];

      // Get today's date in the format provided by the API
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      double totalRain = 0.0;
      int count = 0;

      // Loop through forecasts and filter data for the current day
      for (var forecast in forecasts) {
        String forecastDate = forecast['dt_txt'].split(' ')[0];

        if (forecastDate == today) {
          double rainVolume = forecast['rain']?['3h'] ?? 0.0;
          totalRain += rainVolume;
          count++;
        }
      }

      // If no rain data is found for today, return 0
      if (count == 0) {
        return 0.0;
      }

      // Calculate the average rain for today
      double averageRain = totalRain / count;
      return averageRain;
    } else {
      throw Exception('Failed to fetch rain data');
    }
  }
}

class _RainDataScreenState extends State<RainDataScreen> {
  late WeatherService weatherService;
  double averageRain = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    weatherService = WeatherService(apiKey: 'APIKEY');
    fetchAverageRainForToday();
  }

  Future<void> fetchAverageRainForToday() async {
    try {
      // Example coordinates
      double lat = 6.601024; // Set your latitude
      double lon = 79.954447; // Set your longitude

      double avgRain = await weatherService.getAverageRainForToday(lat, lon);
      setState(() {
        averageRain = avgRain;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching rain data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Average Rain for Today'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Text(
                'Average Rain for Today: ${averageRain.toStringAsFixed(2)} mm',
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}
