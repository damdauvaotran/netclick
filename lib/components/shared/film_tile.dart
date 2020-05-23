import 'package:flutter/material.dart';

import '../../routes/detail_route.dart';

class FilmTile extends StatefulWidget {
  final AssetImage image;
final String filmData;

  FilmTile({@required this.image , this.filmData = ''});

  @override
  State<FilmTile> createState() {
    return FilmTileState();
  }
}

class FilmTileState extends State<FilmTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsRoute(data: widget.filmData)),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 200.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: 130.0,
                decoration:
                    BoxDecoration(image: DecorationImage(image: widget.image)),
                child: Center(
                  child: Icon(Icons.play_circle_outline,
                      color: Colors.white.withOpacity(0.8), size: 80.0),
                ),
              ),
            ],
          ),
        ));
  }
}
