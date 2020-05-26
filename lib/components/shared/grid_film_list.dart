import 'package:flutter/cupertino.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/models/film.dart';

import 'film_tile.dart';

class GridFilmList extends StatelessWidget {

  final List<Film> filmList;

  GridFilmList({this.filmList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: filmList.length,
      itemBuilder: (BuildContext context, int index) {
        Film film = filmList[index];
        return FilmTile(
          filmData: film,
        );
      },
    );
  }
}
