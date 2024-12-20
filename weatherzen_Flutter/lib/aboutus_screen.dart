import 'package:flutter/material.dart';
import 'package:weatherzen/home_screen.dart';
import 'package:weatherzen/services_screen.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({Key? key}) : super(key: key);

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
                    "ABOUT US",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  //const SizedBox(height: 60),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  const Text(
                    "At WeatherZen, we’re all about keeping you safe and informed—whether it’s a sudden rain or a rising flood. Our app gives you real-time weather ",
                    style: TextStyle(
                      fontSize: 17,
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
                    "forecasts and flood alerts with just a few taps!",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  const Text(
                    "Why WeatherZen?",
                    style: TextStyle(
                        fontSize: 22,
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
                    "Because we make staying safe easy and quick. With fast, accurate updates and an intuitive design, you’re always one step ahead of the weather",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
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
                    "and potential floods.",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  const Text(
                    "Our Vision",
                    style: TextStyle(
                        fontSize: 22,
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
                    "We’re on a mission to empower you with the tools and information you need to stay safe—no matter what the skies (or rivers) have in store.",
                    style: TextStyle(
                      fontSize: 17,
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
                    "Real-time updates. Real peace of mind.",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  //const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  const Text(
                    "Meet Our Team",
                    style: TextStyle(
                        fontSize: 22,
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
                    "Behind WeatherZen is a passionate team of engineers, data scientists, and weather enthusiasts dedicated to using technology to make your life safer.",
                    style: TextStyle(
                      fontSize: 17,
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
                    " Our team works tirelessly to ensure you receive reliable information and a seamless experience every time you use the app.",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      //fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //const SizedBox(height: 20),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 400,
                    ),
                    Expanded(
                      child: Container(
                        width: 300,
                        height: 600,
                        padding:
                            const EdgeInsets.only(top: 8, left: 40, right: 40),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 217, 217, 217),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Add person images and positions here
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildPersonWidget(
                                          'assets/person_sehan.jpeg',
                                          'ML Developer'),
                                      SizedBox(width: 40),
                                      _buildPersonWidget(
                                          'assets/person_hasitha.jpg',
                                          'ML Developer'),
                                      SizedBox(width: 40),
                                      _buildPersonWidget(
                                          'assets/person_adee.jpeg',
                                          'UI/UX Designer'),
                                      SizedBox(width: 40),
                                      _buildPersonWidget(
                                          'assets/person_danushka.jpeg',
                                          'Software Developer'),
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
                      width: 400,
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

  Widget _buildPersonWidget(String imagePath, String position) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),
        Text(
          position,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
