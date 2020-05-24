import 'package:netclick/models/episode.dart';

class FilmDetail {
  int filmId;
  String name;
  String description;
  double imdb;
  int epCount;
  String imgUri;
  List<Episode> episodes;

  FilmDetail({this.filmId,
    this.name,
    this.description,
    this.epCount,
    this.imdb,
    this.imgUri,
    this.episodes});

  factory FilmDetail.fromJson(json) {
    List<Episode> tempEpisodes = [];
    json['episodes'].forEach((epJson)=>{
      tempEpisodes.add(Episode.fromJson(epJson))
    });

    return FilmDetail(
      filmId: json['filmId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imdb: json['imdb'].toDouble(),
      epCount: json['epCount'] as int,
      imgUri: json['imgUri'] as String,
      episodes: tempEpisodes,
    );
  }
}
