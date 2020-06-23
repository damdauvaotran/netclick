import 'package:flutter/material.dart';
import 'package:netclick/api/repo/list_repository.dart';
import 'package:netclick/components/shared/app_snackbar.dart';
import 'package:netclick/components/shared/film_tile.dart';
import 'package:netclick/components/shared/loading_indicatior.dart';
import 'package:netclick/models/film.dart';
import 'package:netclick/models/film_list.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _loading = true;
  Future<FilmList> _futureFavoriteFilm;

  @override
  void initState() {
    _fetchFavoriteFilm();
    super.initState();
  }

  void _fetchFavoriteFilm() {
    try {
      this.setState(() {
        _futureFavoriteFilm = ListRepository.getFavoriteList();
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(ErrorSnackBar(message: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Text(
            'Your favorite list',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ),
        Container(
          child: FutureBuilder<FilmList>(
            future: _futureFavoriteFilm,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done ) {
                if (snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                final List<Film> filmList = snapshot.data.films;
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
              return LoadingIndicator();
            },
          ),
        )
      ],
    );
  }
}
