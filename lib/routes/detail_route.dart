import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netclick/api/repo/film_repository.dart';
import 'package:netclick/models/film.dart';
import 'package:netclick/models/film_detail.dart';
import '../components/shared/data.dart';
import 'dart:ui';

class DetailsRoute extends StatefulWidget {
  final Film data;
  final ImageProvider image;

  DetailsRoute({this.data, this.image});

  @override
  _DetailsRouteState createState() => _DetailsRouteState();
}

class _DetailsRouteState extends State<DetailsRoute> {
  Future<FilmDetail> _futureFilmDetail;

  @override
  void initState() {
    super.initState();
    _futureFilmDetail =
        FilmRepository.getFilmInfo(filmId: widget.data.filmId.toString());
  }

  @override
  Widget build(BuildContext context) {
    _onPlayMovie() {
      Navigator.of(context).pushNamed('/watch');
    }

    double width = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      body: FutureBuilder<Object>(
          future: _futureFilmDetail,
          builder: (context, snapshot) {
            print(snapshot.hasError);
            if (snapshot.hasData) {
              return new Container(
                color: Colors.black87,
                child: ListView(
                  children: <Widget>[
                    Container(
                        height: 240.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: widget.image,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black, BlendMode.softLight),
                        )),
                        width: double.infinity,
                        child: new BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10.0,
                                left: 5.0,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: _onPlayMovie,
                                  child: Icon(Icons.play_circle_outline,
                                      color: Colors.white54, size: 100),
                                ),
                              )
                            ],
                          ),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                          width: double.infinity,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Text(
                              widget.data.name,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                          width: double.infinity,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Text(
                              '100%',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.green.withGreen(200),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '2020' + '  16+' + '  1h 52min',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.redAccent.withOpacity(0.6),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                          width: double.infinity,
                        ),
                        Container(
                          width: width,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Flexible(
                                child: new Text(
                                  widget.data.description,
                                  style: new TextStyle(
                                    fontSize: 14,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: width,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Flexible(
                                child: new Text(
                                  'Starring : ' + '10',
                                  style: new TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ),
//                Container(
//                  margin: EdgeInsets.symmetric(vertical: 10.0),
//                  padding: EdgeInsets.symmetric(horizontal: 20),
//                  width: double.infinity,
//                  height: 80,
//                  child: Row(
//                    children: <Widget>[
//                      Column(
//                        children: <Widget>[
//                          IconButton(
//                            icon: Icon(Icons.done, color: Colors.white),
//                            onPressed: () {},
//                          ),
//                          Text(
//                            'My List',
//                            style:
//                            TextStyle(color: Colors.white30, fontSize: 10),
//                          )
//                        ],
//                      ),
//                      SizedBox(width: 40),
//                      Column(
//                        children: <Widget>[
//                          IconButton(
//                            icon: Icon(Icons.thumb_up, color: Colors.white),
//                            onPressed: () {},
//                          ),
//                          Text(
//                            'Rate',
//                            style:
//                            TextStyle(color: Colors.white30, fontSize: 10),
//                          )
//                        ],
//                      ),
//                      SizedBox(
//                        width: 40,
//                      ),
//                      Column(
//                        children: <Widget>[
//                          IconButton(
//                            icon: Icon(Icons.share, color: Colors.white),
//                            onPressed: () {},
//                          ),
//                          Text(
//                            'Share',
//                            style:
//                            TextStyle(color: Colors.white30, fontSize: 10),
//                          )
//                        ],
//                      ),
//                      SizedBox(
//                        width: 40,
//                      ),
//                      Column(
//                        children: <Widget>[
//                          IconButton(
//                            icon:
//                            Icon(Icons.file_download, color: Colors.white),
//                            onPressed: () {},
//                          ),
//                          Text(
//                            'Download',
//                            style:
//                            TextStyle(color: Colors.white30, fontSize: 10),
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
                        Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        SizedBox(
                          height: 15,
                          width: double.infinity,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  child: Container(
                                    color: Colors.red,
                                    height: 2,
                                    width: 80,
                                  ),
                                  height: 2.0,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'EPISODES',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
//                    SizedBox(
//                      width: 20,
//                    ),
//                    Text(
//                      'MORE LIKE THIS',
//                      style: TextStyle(fontSize: 15, color: Colors.white54),
//                    ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        widget.data.name == 'false'
                            ? FlatButton(
                                onPressed: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(100),
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 120,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Season 1',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 10,
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        episodeBlock(context, '1. The One With The Blackout'),
                        episodeBlock(
                            context, '2. The One Where Everyone Knows'),
                        episodeBlock(
                            context, '3. The one With Late Thanksgiving')
                      ],
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Column(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
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
          }),
    );
  }

  Container episodeBlock(context, epTitle) {
    _onPlayMovie() {
      Navigator.of(context).pushNamed('/watch');
    }

    return Container(
      height: 150,
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: _onPlayMovie,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: widget.image,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black, BlendMode.softLight))),
                        width: 100,
                        height: 60,
                        child: Center(
                          child: Icon(Icons.play_arrow,
                              size: 35, color: Colors.white),
                        )),
                    SizedBox(
                      height: 2,
                      child: Container(width: 60, color: Colors.red),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      epTitle,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '54 min',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Flexible(
            child: Text(
              widget.data.description,
              style: TextStyle(color: Colors.white30, fontSize: 11),
            ),
          ),
          Divider(color: Colors.black, height: 40)
        ],
      ),
    );
  }
}
