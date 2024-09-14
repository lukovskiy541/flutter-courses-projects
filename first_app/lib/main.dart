import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: const GradientContainer(colors: [ Colors.purple, Color.fromARGB(255, 76, 28, 85)],)),
    ),
  );
}


