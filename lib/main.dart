import 'package:flutter/material.dart';
import 'package:myapp/pages/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('Weather_App'),
      // the home calls calls the Weather_App class which is imported into this file
      home:Weather_App(),
    );
  }
}
