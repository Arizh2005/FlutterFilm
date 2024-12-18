import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/film.dart';

class FilmService {
  final String baseUrl = 'http://127.0.0.1:8000/api/films';

  /// Gets a list of all films.
  ///
  /// Throws a [Exception] if the GET request fails.
  Future<List<Film>> getFilms() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((film) => Film.fromJson(film)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Film> createFilm(Film film) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(film.toJson()),
    );
    if (response.statusCode == 201) {
      return Film.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create product');
    }
  }

  Future<void> updateFilm(Film film) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${film.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(film.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update Film');
    }
  }

  Future<void> deleteFilm(int filmId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$filmId'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception(
          'Failed to delete product. Status code: ${response.statusCode}');
    }
  }
}
