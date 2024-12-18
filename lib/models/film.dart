class Film {
  int? id;
  String title;
  String description;
  String director;
  int releaseYear;
  String genre;
  String poster;

  Film({
    this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.releaseYear,
    required this.genre,
    required this.poster,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      director: json['director'],
      releaseYear: json['release_year'],
      genre: json['genre'],
      poster: json['poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'director': director,
      'release_year': releaseYear,
      'genre': genre,
      'poster': poster,
    };
  }
}
