import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/models/film.dart';
import 'package:netclick/models/film_detail.dart';
import 'package:netclick/models/film_list.dart';

class ListRepository {
  static Future<FilmList> getFavoriteList() async {
    var data = await getAuth(url: 'list/favorite');
    FilmList favoriteList = FilmList.fromJson(data);
    return favoriteList;
  }
}
