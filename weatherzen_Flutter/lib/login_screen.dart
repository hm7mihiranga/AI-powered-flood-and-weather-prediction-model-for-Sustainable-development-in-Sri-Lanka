import 'package:flutter/material.dart';
import 'package:weatherzen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _errorMessage = '';

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
                      width: 480,
                    ),
                    Expanded(
                      child: Container(
                        width: 300,
                        height: 600,
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 217, 217, 217),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        // Add your logo here
                                        Image.asset('assets/weat_logo.png',
                                            height: 150),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Add your logo here
                                      const Text(
                                        "WeatherZen",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(231, 46, 31, 84),
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         const Text(
                                //           "WeatherZen",
                                //           style: TextStyle(
                                //               color: Color(0xFF221543),
                                //               fontSize: 15),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "User name",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                decorationColor: Colors.white,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: TextField(
                                          controller: _usernameController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                19, 255, 255, 255),
                                            hintText: 'Enter Username',
                                            hintStyle: TextStyle(
                                                fontSize: 12.8,
                                                color: const Color.fromARGB(
                                                    199, 255, 255, 255)),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .white, // Change the border color here
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .white, // Border color when focused
                                                width: 2.0,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Password",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                decorationColor: Colors.white,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: TextField(
                                          controller: _passwordController,
                                          obscureText: _obscurePassword,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                17, 255, 255, 255),
                                            hintText: 'Enter Password',
                                            hintStyle: TextStyle(
                                                fontSize: 12.8,
                                                color: const Color.fromARGB(
                                                    199, 255, 255, 255)),
                                            suffixIcon: IconButton(
                                              color: Colors.white,
                                              icon: Icon(_obscurePassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _obscurePassword =
                                                      !_obscurePassword;
                                                });
                                              },
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .white, // Change the border color here
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .white, // Border color when focused
                                                width: 2.0,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (_errorMessage.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Text(
                                            _errorMessage,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),

                                      // Login button
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _login();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                            ),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
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
                      width: 480,
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

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Check if the username and password match predefined values
    if (username == 'user' && password == '1234') {
      // Clear the error message
      setState(() {
        _errorMessage = '';
      });

      // Navigate to another screen if login is successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show error message if login fails
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }
}
