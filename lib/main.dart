import 'package:flutter/material.dart';
import 'aquarium_screen.dart'; // Corrected import path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW-05: Virtual Aquarium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AquariumScreen(), // Main screen with the aquarium
    );
  }
}
