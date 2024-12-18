import 'package:flutter/material.dart';
import '../models/film.dart';

class FilmCard extends StatelessWidget {
  final Film film;

  const FilmCard({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(film.title),
        subtitle: Text(film.genre),
        onTap: () {
          // Navigate to Film Detail Screen
        },
      ),
    );
  }
}
