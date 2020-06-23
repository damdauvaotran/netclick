import 'package:netclick/models/film.dart';

class FilmList {
  FilmList({
    this.listName = '',
    this.favorite = false,
    this.userId = '',
    this.films,
  });

  String listName;
  bool favorite;
  String userId;
  List<Film> films;

  factory FilmList.fromJson(Map<String, dynamic> json) {
    List list = List.from(json['films']);
    List<Film> favoriteList = list.map((film) => Film.fromJson(film)).toList();
    return FilmList(
      listName: json['userName'].toString(,
      favorite: json['name'] as bool,
      userId: json['userId'].toString(),
      films: favoriteList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listName': listName,
      'favorite': favorite.toString(),
      'userId': userId,
    };
  }
}
