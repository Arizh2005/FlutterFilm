class Film {
  final int? id;
  final String title;
  final String description;
  final String director;
  final int releaseYear;
  final String genre;

  Film({
    this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.releaseYear,
    required this.genre,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      director: json['director'],
      releaseYear: json['release_year'],
      genre: json['genre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'director': director,
      'release_year': releaseYear,
      'genre': genre,
    };
  }
}
