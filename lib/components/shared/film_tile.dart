import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/models/film.dart';

import '../../routes/detail_route.dart';

class FilmTile extends StatefulWidget {
  final Film filmData;

  FilmTile({@required this.filmData});

  @override
  State<FilmTile> createState() {
    return FilmTileState();
  }
}

class FilmTileState extends State<FilmTile> {
  ImageProvider _image;

  @override
  void initState() {
    _image = NetworkImage(
        Uri.http(baseUrl, 'images/${widget.filmData.imgUri}').toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsRoute(image: _image, data: widget.filmData)),
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
                    BoxDecoration(image: DecorationImage(image: _image)),
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
