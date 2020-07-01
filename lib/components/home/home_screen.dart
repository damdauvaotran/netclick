import 'package:flutter/material.dart';
import 'package:netclick/api/repo/film_repository.dart';
import 'package:netclick/components/home/category_list.dart';
import 'package:netclick/components/shared/film_tile.dart';
import 'package:netclick/models/film.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Film>> _futureFilmList;
  Future<List<Film>> _futureActionFilmList;
  Future<List<Film>> _futureComedyFilmList;
  Future<List<Film>> _futureRomanceFilmList;
  Future<List<Film>> _futureAnimatedFilmList;

  @override
  void initState() {
    // TODO: implement initState
    _futureFilmList = FilmRepository.getAllFilm();
    _futureActionFilmList = FilmRepository.getAllFilm(category: '1');
    _futureComedyFilmList = FilmRepository.getAllFilm(category: '2');
    _futureRomanceFilmList = FilmRepository.getAllFilm(category: '3');
    _futureAnimatedFilmList = FilmRepository.getAllFilm(category: '4');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        CategoryList(futureFilmList: _futureFilmList, name: 'Top Picks For You'),
        CategoryList(futureFilmList: _futureAnimatedFilmList, name: 'Action'),
        CategoryList(futureFilmList: _futureComedyFilmList, name: 'Comedy'),
        CategoryList(futureFilmList: _futureRomanceFilmList, name: 'Romance'),
        CategoryList(futureFilmList: _futureAnimatedFilmList, name: 'Animated'),
      ],
    );
  }
}
