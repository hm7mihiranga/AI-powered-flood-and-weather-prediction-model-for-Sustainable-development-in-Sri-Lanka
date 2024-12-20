import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:weatherzen/aboutus_screen.dart';
import 'package:weatherzen/home_screen.dart';
import 'package:weatherzen/services_screen.dart';

class PredictWeatherHome extends StatefulWidget {
  @override
  _PredictWeatherHomeState createState() => _PredictWeatherHomeState();
}

class _PredictWeatherHomeState extends State<PredictWeatherHome> {
  html.File? _imageFile;
  Uint8List? _imageBytes;
  String? _prediction;
  bool _isLoading = false;

  // Function to pick an image from the local file system
  Future<void> _pickImage() async {
    html.File? pickedFile = await ImagePickerWeb.getImageAsFile();
    if (pickedFile != null) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(pickedFile);
      reader.onLoadEnd.listen((event) {
        setState(() {
          _imageFile = pickedFile;
          _imageBytes = reader.result as Uint8List;
          _prediction = null; // Reset prediction
        });
      });
    }
  }

//Uri.parse('http://127.0.0.1:5000/predict'),
  // Function to send the image to the Flask backend and get a prediction
  Future<void> _predictImage() async {
    if (_imageFile == null || _imageBytes == null) return;

    setState(() {
      _isLoading = true;
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5000/predict'),
    );

    var multipartFile = http.MultipartFile.fromBytes('image', _imageBytes!,
        filename: _imageFile!.name);
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var jsonResponse = jsonDecode(responseData.body);
      String mostFrequentLabel = jsonResponse['label'];
      //String error = jsonResponse['error'];// erooooooooorrrr
      String predictionMessage = '';

      if (mostFrequentLabel == 'Fish') {
        predictionMessage =
            "Fair weather, but if the clouds thicken or lower, rain may be on the way.";
      } else if (mostFrequentLabel == 'Gravel') {
        predictionMessage =
            "Fair weather, but if it becomes more extensive or dense, it could suggest an impending change in weather to Rainy.";
      } else if (mostFrequentLabel == 'Sugar') {
        predictionMessage = "There is a high possibility of rain.";
      } else if (mostFrequentLabel == 'Flower') {
        predictionMessage =
            "It can change to a rainy situation, suggesting fair weather.";
      }

      setState(() {
        _prediction = "Prediction: $predictionMessage";
        _isLoading = false;
      });
    } else {
      setState(() {
        _prediction = "Error: Please upload valid image";
        _isLoading = false;
      });
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
                    "Predict Weather Now",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(87, 9, 4, 24),
                          const Color.fromARGB(160, 0, 0, 0)
                        ], // Define your gradient colors
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50),
                        backgroundColor: const Color(0x00000000),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        _pickImage();
                      },
                      child: const Text(
                        "Upload Image",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(87, 9, 4, 24),
                          const Color.fromARGB(160, 0, 0, 0)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50),
                        backgroundColor: const Color(0x00000000),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        _predictImage();
                      },
                      child: const Text(
                        "Predict weather",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Upload current sky image or Realtime satellite image of your area",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                    ),
                    Expanded(
                      child: Container(
                        width: 300,
                        height: 400,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 217, 217, 217),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Conditionally render content based on the state
                            if (_imageBytes == null && _prediction == null)
                              const Text(
                                "Upload a photo to discover instant, AI-driven predictions tailored just for you. \nGet results in seconds!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              )
                            else if (_imageBytes != null && _prediction == null)
                              Column(
                                children: [
                                  Image.memory(
                                    _imageBytes!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )
                            else if (_imageBytes != null && _prediction != null)
                              Column(
                                children: [
                                  Image.memory(
                                    _imageBytes!, // Display the uploaded image
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    _prediction!, // Show the prediction result
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  // Display specific image based on mostFrequentLabel
                                  if (_prediction ==
                                      'Prediction: Fair weather, but if the clouds thicken or lower, rain may be on the way.')
                                    Image.asset(
                                      'assets/fish_image.png', // Path to fish image
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  else if (_prediction ==
                                      'Prediction: Fair weather, but if it becomes more extensive or dense, it could suggest an impending change in weather to Rainy.')
                                    Image.asset(
                                      'assets/gravel_image.png', // Path to gravel image
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  else if (_prediction ==
                                      'Prediction: There is a high possibility of rain.')
                                    Image.asset(
                                      'assets/sugar_image.png', // Path to sugar image
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  else if (_prediction ==
                                      'Prediction: It can change to a rainy situation, suggesting fair weather.')
                                    Image.asset(
                                      'assets/flower_image.png', // Path to flower image
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
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
