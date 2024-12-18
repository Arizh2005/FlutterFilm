import 'package:flutter/material.dart';
import '../models/film.dart';
import '../services/film_service.dart';

class AddEditFilmScreen extends StatefulWidget {
  final Film? film;

  AddEditFilmScreen({this.film});

  @override
  _AddEditFilmScreenState createState() => _AddEditFilmScreenState();
}

class _AddEditFilmScreenState extends State<AddEditFilmScreen> {
  final _formKey = GlobalKey<FormState>();
  final FilmService _filmService = FilmService();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _directorController;
  late TextEditingController _yearController;
  late TextEditingController _genreController;
  late TextEditingController _posterController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.film?.title ?? '');
    _descriptionController = TextEditingController(text: widget.film?.description ?? '');
    _directorController = TextEditingController(text: widget.film?.director ?? '');
    _yearController = TextEditingController(text: widget.film?.releaseYear.toString() ?? '');
    _genreController = TextEditingController(text: widget.film?.genre ?? '');
    _posterController = TextEditingController(text: widget.film?.poster ?? '');
  }

  void _saveFilm() async {
    if (_formKey.currentState!.validate()) {
      final film = Film(
        id: widget.film?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        director: _directorController.text,
        releaseYear: int.tryParse(_yearController.text) ?? 0,
        genre: _genreController.text,
        poster: _posterController.text,
      );

      if (widget.film == null) {
        await _filmService.createFilm(film);
      } else {
        await _filmService.updateFilm(film);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.film == null ? 'Add Film' : 'Edit Film')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _directorController,
                decoration: InputDecoration(labelText: 'Director'),
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Release Year'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
              ),
              TextFormField(
                controller: _posterController,
                decoration: InputDecoration(labelText: 'Poster URL'),
                validator: (value) => value!.isEmpty ? 'Enter a poster URL' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFilm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
