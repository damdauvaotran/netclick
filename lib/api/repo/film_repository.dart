import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/models/film.dart';
import 'package:netclick/models/film_detail.dart';

class FilmRepository {
  static Future<List<Film>> getAllFilm({String name = ''}) async {
    List data = await getAuth(url: 'film', query: {'name': name});
    List<Film> filmList = data.map((film) => Film.fromJson(film)).toList();
    return filmList;
  }

  static Future<FilmDetail> getFilmInfo({@required String filmId}) async {
    Map<String, dynamic> data = await getAuth(url: 'film/$filmId');
    return FilmDetail.fromJson(data);
  }

  static Future addToFavorite({@required String filmId}) async {
    Map<String, dynamic> data =
        await postAuth(url: '/list/favorite/add', body: {'filmId': filmId});
    return data;
  }

  static Future removeFromFavorite({@required String filmId}) async {
    Map<String, dynamic> data =
        await postAuth(url: '/list/favorite/remove', body: {'filmId': filmId});
    return data;
  }
}
