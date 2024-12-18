import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/film.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Film>> films;

  @override
  void initState() {
    super.initState();
    films = apiService.fetchFilms();
  }

  void refreshFilms() {
    setState(() {
      films = apiService.fetchFilms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Film CRUD')),
      body: FutureBuilder<List<Film>>(
        future: films,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No films available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final film = snapshot.data![index];
                return ListTile(
                  title: Text(film.title),
                  subtitle: Text(film.genre),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await apiService.deleteFilm(film.id!);
                      refreshFilms();
                    },
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditScreen(
                        film: film,
                        refreshFilms: refreshFilms,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditScreen(refreshFilms: refreshFilms),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
