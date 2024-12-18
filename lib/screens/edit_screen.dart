import 'package:flutter/material.dart';
import '../models/film.dart';
import '../services/api_service.dart';

class EditScreen extends StatefulWidget {
  final Film film;
  final VoidCallback refreshFilms;

  EditScreen({required this.film, required this.refreshFilms});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _directorController;
  late TextEditingController _releaseYearController;
  late TextEditingController _genreController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.film.title);
    _descriptionController = TextEditingController(text: widget.film.description);
    _directorController = TextEditingController(text: widget.film.director);
    _releaseYearController = TextEditingController(text: widget.film.releaseYear.toString());
    _genreController = TextEditingController(text: widget.film.genre);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _directorController.dispose();
    _releaseYearController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  void _updateFilm() async {
    if (_formKey.currentState!.validate()) {
      final updatedFilm = Film(
        id: widget.film.id,
        title: _titleController.text,
        description: _descriptionController.text,
        director: _directorController.text,
        releaseYear: int.parse(_releaseYearController.text),
        genre: _genreController.text,
      );

      try {
        await _apiService.updateFilm(updatedFilm);
        widget.refreshFilms();
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Description is required' : null,
              ),
              TextFormField(
                controller: _directorController,
                decoration: InputDecoration(labelText: 'Director'),
                validator: (value) => value == null || value.isEmpty ? 'Director is required' : null,
              ),
              TextFormField(
                controller: _releaseYearController,
                decoration: InputDecoration(labelText: 'Release Year'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Release year is required'
                    : int.tryParse(value) == null
                        ? 'Must be a valid number'
                        : null,
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
                validator: (value) => value == null || value.isEmpty ? 'Genre is required' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateFilm,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
