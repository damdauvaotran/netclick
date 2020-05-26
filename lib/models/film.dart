import 'package:netclick/models/episode.dart';

class Film {
  int filmId;
  String name;
  String description;
  double imdb;
  int epCount;
  String imgUri;
  int year;
  String starring;

  Film({
    this.filmId,
    this.name,
    this.description,
    this.epCount,
    this.imdb,
    this.imgUri,
    this.year,
    this.starring,
  });

  factory Film.fromJson(json) {
    return Film(
      filmId: json['filmId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imdb: json['imdb'].toDouble(),
      epCount: json['epCount'] as int,
      imgUri: json['imgUri'] as String,
      year: json['year'] as int,
      starring: json['starring'] as String,
    );
  }
}
