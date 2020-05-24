import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';

class FilmRepository {
  static Future<Map<String, dynamic>> getAllFilm({String category}) async {
    Map<String, dynamic> data =
        await post(url: '/auth/signUp', query: {category: category});
    return data;
  }

  static Future<Map<String, dynamic>> getFilmInfo({@required String filmId}) async {
    Map<String, dynamic> data =
        await post(url: '/auth/signUp/$filmId');
    return data;
  }
}
