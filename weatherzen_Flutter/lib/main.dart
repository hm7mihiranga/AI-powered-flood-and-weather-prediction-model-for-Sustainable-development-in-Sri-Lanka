import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weatherzen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBACWgZ77NPd7aWyBlzmX7OEGt6tx-SZjw",
        authDomain: "weatherzen-c87f6.firebaseapp.com",
        projectId: "weatherzen-c87f6",
        storageBucket: "weatherzen-c87f6.appspot.com",
        messagingSenderId: "292375270014",
        appId: "1:292375270014:web:a7ec0993a56beacaeefe2f",
        measurementId: "G-57Y855L39K",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
