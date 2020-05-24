import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/models/film.dart';

class FilmRepository {
  static Future<List<Film>> getAllFilm({String category}) async {
    List data = await getAuth(url: '/film');
    List<Film> filmList = data.map((film) => Film.fromJson(film)).toList();
    return filmList;
  }

  static Future<Film> getFilmInfo({@required String filmId}) async {
    Map<String, dynamic> data = await getAuth(url: '/film/$filmId');
    return Film.fromJson(data);
  }
}
