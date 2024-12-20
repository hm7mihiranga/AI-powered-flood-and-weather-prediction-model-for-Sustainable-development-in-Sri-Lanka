import 'package:flutter/material.dart';
import 'package:weatherzen/aboutus_screen.dart';
import 'package:weatherzen/predict_weather_home.dart';
import 'package:weatherzen/services_screen.dart';
import 'package:weatherzen/weather_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {},
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
                // TextButton(
                //   onPressed: () {},
                //   child: const Text("Sign In",
                //       style: TextStyle(color: Color(0xFF221543))),
                // ),
                // TextButton(
                //   onPressed: () {},
                //   child: Container(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: Colors.purpleAccent,
                //     ),
                //     child: const Text("Register",
                //         style: TextStyle(color: Colors.white)),
                //   ),
                // ),
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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/elements_all.png',
                          width: 800,
                          height: 150,
                        ),
                        SizedBox(width: 30),
                        // Image.asset(
                        //   'assets/moon_rain.png',
                        //   width: 80,
                        //   height: 80,
                        // ),
                        // SizedBox(width: 30),
                        // Image.asset(
                        //   'assets/Sun_rain.png',
                        //   width: 80,
                        //   height: 80,
                        // ),
                        // SizedBox(width: 30),
                        // Image.asset(
                        //   'assets/Sun_mid_rain.png',
                        //   width: 80,
                        //   height: 80,
                        // ),
                        // SizedBox(width: 30),
                        // Image.asset(
                        //   'assets/Tornado.png',
                        //   width: 80,
                        //   height: 80,
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                        ),
                        Expanded(
                          child: Container(
                            width: 300,
                            height: 400,
                            padding: const EdgeInsets.all(
                                50.0), // Adds space inside the box
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 217, 217,
                                  217), // Background color of the box
                              borderRadius: BorderRadius.circular(
                                  15.0), // Rounded corners
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Curious if it's going to rain soon?",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Upload a picture of the sky, and we'll analyze it to give you instant weather predictions based on the current conditions",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 45),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 129, 88, 232),
                                        const Color.fromARGB(123, 34, 21, 67)
                                      ], // Define your gradient colors
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(300, 100),
                                      backgroundColor: const Color(0x00000000),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PredictWeatherHome()),
                                      );
                                    },
                                    child: const Text(
                                      "Predict Weather Now!",
                                      style: TextStyle(
                                          color: Color(0xFFE4BF2E),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Container(
                            width: 300,
                            height: 400,
                            padding: const EdgeInsets.all(
                                50.0), // Adds space inside the box
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 217, 217,
                                  217), // Background color of the box
                              borderRadius: BorderRadius.circular(
                                  15.0), // Rounded corners
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Worried about potential floods in your area?",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Select your location to check the water levels of nearby rivers and receive a real-time flood risk warning.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 45),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 129, 88, 232),
                                        const Color.fromARGB(123, 34, 21, 67)
                                      ], // Define your gradient colors
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        50), // Match the border radius of the button
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(300, 100),
                                      backgroundColor: const Color(0x00000000),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FloodPrediction()),
                                      );
                                    },
                                    child: const Text(
                                      "Check Flood Risk",
                                      style: TextStyle(
                                          color: Color(0xFFE4BF2E),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/homepng1.png', // Path to your left image
                width: 280, // Adjust width as needed
                height: 280, // Adjust height as needed
              ),
            ),
            // Bottom-right image
            Positioned(
              bottom: -85,
              right: -5,
              child: Opacity(
                opacity: 0.5, // Set the opacity value (0.0 to 1.0)
                child: Image.asset(
                  'assets/house_flood.gif', // Path to your right image
                  width: 350, // Adjust width as needed
                  height: 350, // Adjust height as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
