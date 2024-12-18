// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilmHomeScreen(),
    );
  }
}