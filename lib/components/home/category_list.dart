import 'package:flutter/material.dart';
import 'package:netclick/components/shared/film_tile.dart';
import 'package:netclick/models/film.dart';

class CategoryList extends StatelessWidget {

  final String name;
  final Future<List<Film>> futureFilmList;

  CategoryList({@required this.name, @required this.futureFilmList});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Film>>(
      future: futureFilmList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 10.0, height: 10.0),
                  Text.rich(
                    TextSpan(text: name),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat'),
                  )
                ],
              ),
              Container(
                height: 240,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  height: 240.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Film film = snapshot.data[index];
                      return FilmTile(
                        filmData: film,
                      );
                    },
                  ),
                ),
              ),

            ],
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text('Please wait'),
            ],
          ),
        );
      },
    );
  }

}