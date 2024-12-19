import 'package:flutter/material.dart';
import '../film_list_screen.dart';
import '../film_crud_screen.dart';

class FilmHomeScreen extends StatefulWidget {
  const FilmHomeScreen({super.key});

  @override
  _FilmHomeScreenState createState() => _FilmHomeScreenState();
}

class _FilmHomeScreenState extends State<FilmHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    FilmListScreen(),
    FilmCrudScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
    );
  }
}
