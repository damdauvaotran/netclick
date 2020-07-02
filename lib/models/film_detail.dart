import 'package:netclick/models/episode.dart';

class FilmDetail {
  int filmId;
  String name;
  String description;
  double imdb;
  int epCount;
  String imgUri;
  bool liked;
  List<Episode> episodes;

  FilmDetail(
      {this.filmId,
      this.name,
      this.description,
      this.epCount,
      this.imdb,
      this.imgUri,
      this.liked,
      this.episodes});

  factory FilmDetail.fromJson(json) {
    List<Episode> tempEpisodes = [];
    json['episodes'].forEach((epJson) {
      tempEpisodes.add(Episode.fromJson(epJson));
    });
    return FilmDetail(
      filmId: json['filmId'] as int,
      name: json['name'].toString(),
      description: json['description'].toString(),
      imdb: json['imdb'].toDouble(),
      epCount: json['epCount'] as int,
      imgUri: json['imgUri'].toString(),
      liked: json['liked'].toString() == 'true',
      episodes: tempEpisodes,
    );
  }
}
