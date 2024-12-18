import 'package:flutter/material.dart';
import '../models/film.dart';

class DetailScreen extends StatelessWidget {
  final Film film;

  DetailScreen({required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(film.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${film.title}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Description: ${film.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Director: ${film.director}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Release Year: ${film.releaseYear}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Genre: ${film.genre}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
