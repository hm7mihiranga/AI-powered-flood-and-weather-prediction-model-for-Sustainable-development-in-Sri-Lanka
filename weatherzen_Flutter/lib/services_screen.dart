import 'package:flutter/material.dart';
import 'package:weatherzen/aboutus_screen.dart';
import 'package:weatherzen/home_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Image.asset(
                  //   'assets/elements_all.png',
                  //   width: 200,
                  //   height: 20,
                  // ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  const Text(
                    "Our Services",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  const Text(
                    "Welcome to WeatherZen! Our app provides two core services to help you stay informed and safe from unpredictable weather and flood conditions. Explore the features below to",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  const Text(
                    "see how we can assist you.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //const SizedBox(height: 20),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                    ),
                    Expanded(
                      child: Container(
                        width: 300,
                        height: 480,
                        padding:
                            const EdgeInsets.only(top: 8, left: 40, right: 40),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 217, 217, 217),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  'assets/rain.gif',
                                  width: 300,
                                  height: 480,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 20),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "1. REAL-TIME WEATHER PREDICTION",
                                        style: TextStyle(
                                            color: Color(0xFFE4BF2E),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Ever wonder if it’s about to rain? With our Real-Time Weather \nPrediction,you can quickly find out by uploading an image \nof the sky.",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "How it works",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Simply take a picture of the sky and upload it. Our system will\nanalyze the image using advanced algorithms and give you a\nprediction of upcoming weather conditions, like whether rain\nis approaching.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Why use this",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "This feature helps you prepare for rain or bad weather in real-time, \nbased on the sky above you, so you're always a step ahead.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Key Benefits",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          //decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "• Quick and easy weather updates",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "• Accurate, image-based predictions",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "• Be ready for rain or clear skies!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                        height: 480,
                        padding:
                            const EdgeInsets.only(top: 8, left: 40, right: 35),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 217, 217, 217),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Opacity(
                                opacity: 0.09,
                                child: Image.asset(
                                  'assets/flood_service.gif',
                                  width: 300,
                                  height: 480,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 20),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "2. FLOOD DETECTION & ALERTS",
                                        style: TextStyle(
                                            color: Color(0xFFE4BF2E),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Concerned about floods in your area? Our Flood Detection feature \ngives you real-time information about potential flood risks near you.",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "How it works",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text:
                                                    "Just select your location from the dropdown menu. Our system finds \nthe closest river and provides you with the current water level and \nchanges over the past hour. Based on this, you’ll receive a \nflood warning level: ",
                                              ),
                                              TextSpan(
                                                text: "Normal",
                                                style: const TextStyle(
                                                  color: Colors
                                                      .green, // Color for "Normal"
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ", ",
                                              ),
                                              TextSpan(
                                                text: "Alert",
                                                style: const TextStyle(
                                                  color: Colors.yellow,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ", ",
                                              ),
                                              TextSpan(
                                                text: "Minor Flood",
                                                style: const TextStyle(
                                                  color: Colors
                                                      .orange, // Color for "Alert"
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ", or ",
                                              ),
                                              TextSpan(
                                                text: "Major Flood",
                                                style: const TextStyle(
                                                  color: Colors
                                                      .red, // Color for "Major Risk"
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ".",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Why use this",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "This feature helps you stay informed about nearby flood risks so \nyou can act quickly and stay safe.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Key Benefits",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          //decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "• Real-time flood warnings based on river levels",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "• Easy location-based search",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
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
