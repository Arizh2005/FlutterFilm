import 'package:flutter/material.dart';
import '../models/film.dart';
import '../services/film_service.dart';

class FilmCrudScreen extends StatefulWidget {
  final Film? film;

  FilmCrudScreen({this.film});

  @override
  _FilmCrudScreenState createState() => _FilmCrudScreenState();
}

class _FilmCrudScreenState extends State<FilmCrudScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title, _description, _director, _genre, _poster;
  late int _releaseYear;

  @override
  void initState() {
    super.initState();
    if (widget.film != null) {
      _title = widget.film!.title;
      _description = widget.film!.description;
      _director = widget.film!.director;
      _genre = widget.film!.genre;
      _releaseYear = widget.film!.releaseYear;
      _poster = widget.film!.poster;
    } else {
      _title = '';
      _description = '';
      _director = '';
      _genre = '';
      _releaseYear = 0;
      _poster = '';
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final film = Film(
        id: widget.film?.id ?? 0,
        title: _title,
        description: _description,
        director: _director,
        genre: _genre,
        releaseYear : _releaseYear,
        poster: _poster,
      );
      try {
        if (widget.film == null) {
          await FilmService().createFilm(film);
        } else {
          await FilmService().updateFilm(film);
        }
        Navigator.pop(context, true); // Explicitly pass true
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save Film'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film == null ? 'Create Film' : 'Edit Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Title Film';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _director,
                decoration: InputDecoration(labelText: 'Director'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a director';
                  }
                  return null;
                },
                onSaved: (value) => _director = value!,
              ),
              TextFormField(
                initialValue: _genre,
                decoration: InputDecoration(labelText: 'Genre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Genre';
                  }
                  return null;
                },
                onSaved: (value) => _genre = value!,
              ),
              TextFormField(
                initialValue: _releaseYear.toString(),
                decoration: InputDecoration(labelText: 'Release Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Release Year';
                  }
                  return null;
                },
                onSaved: (value) => _releaseYear = int.parse(value!),
              ),
              TextFormField(
                initialValue: _poster,
                decoration: InputDecoration(labelText: 'Image'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image';
                  }
                  return null;
                },
                onSaved: (value) => _poster = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.film == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}