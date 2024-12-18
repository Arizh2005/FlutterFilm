import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/film.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api/films/';

  Future<List<Film>> fetchFilms() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> filmsData = jsonResponse['data']['data']; // Akses ke data film
        return filmsData.map((film) => Film.fromJson(film)).toList();
      } else {
        throw Exception('Failed to load films');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> createFilm(Film film) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(film.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create film');
    }
  }

  Future<void> updateFilm(Film film) async {
    final response = await http.put(
      Uri.parse('$baseUrl${film.id}/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(film.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update film');
    }
  }

  Future<void> deleteFilm(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id/'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete film');
    }
  }
}
