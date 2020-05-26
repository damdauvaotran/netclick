import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/api/repo/film_repository.dart';
import 'package:netclick/components/shared/app_snackbar.dart';
import 'package:netclick/components/shared/film_tile.dart';
import 'package:netclick/models/app_state.dart';
import 'package:netclick/models/film.dart';
import 'package:netclick/redux/actions.dart';

class HomepageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Future<List<Film>> _futureFilmList;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    _controller = new TabController(length: 3, vsync: this);
    _futureFilmList = FilmRepository.getAllFilm();
  }

  _onTapTabBar(int index) {
    if (index == 2) {
      StoreProvider.of<AppState>(context).dispatch(UpdateToken(token: ''));
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      bottomNavigationBar: new Material(
        elevation: 1.0,
        color: Colors.black87,
        child: new TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
          indicatorColor: Colors.black,
          tabs: <Tab>[
            new Tab(
              icon: new Icon(Icons.home),
              child: Text('Home'),
            ),
            new Tab(
              icon: new Icon(Icons.search),
              child: Text('Search'),
            ),
//            new Tab(
//              icon: new Icon(Icons.tv),
//            ),
//            new Tab(
//              icon: new Icon(Icons.file_download),
//            ),
            new Tab(
              icon: new Icon(Icons.power_settings_new),
              child: Text('Logout'),
            ),
          ],
          controller: _controller,
          onTap: _onTapTabBar,
        ),
      ),
      body: new Container(
        child: FutureBuilder<List<Film>>(
          future: _futureFilmList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
//                return ListView(
//                  children: <Widget>[
//                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        SizedBox(width: 10.0, height: 10.0),
//                        Text.rich(
//                          TextSpan(text: 'Continue watching for Ram'),
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 14.0,
//                              fontWeight: FontWeight.w600,
//                              fontFamily: 'Montserrat'),
//                        )
//                      ],
//                    ),
//                    Container(
//                      margin: EdgeInsets.symmetric(vertical: 5.0),
//                      height: 240.0,
//                      child: ListView(
//                        scrollDirection: Axis.horizontal,
//                        children: <Widget>[
//                          FilmTile(
//                            image: AssetImage('assets/images/ghoul.jpg'),
//                            filmData: 'Ghl',
//                          ),
//                          FilmTile(
//                            image: AssetImage('assets/images/alc.jpg'),
//                            filmData: 'Alc',
//                          ),
//                        ],
//                      ),
//                    ),
//                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        SizedBox(width: 10.0, height: 10.0),
//                        Text.rich(
//                          TextSpan(text: 'Top Picks For You'),
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 14.0,
//                              fontWeight: FontWeight.w800,
//                              fontFamily: 'Montserrat'),
//                        )
//                      ],
//                    ),
//                    Container(
//                      margin: EdgeInsets.symmetric(vertical: 5.0),
//                      height: 200.0,
//                      child: ListView(
//                        scrollDirection: Axis.horizontal,
//                        children: <Widget>[
//                          FilmTile(
//                            image: AssetImage('assets/images/ghoul.jpg'),
//                            filmData: 'Ghl',
//                          ),
//                          FilmTile(
//                            image: AssetImage('assets/images/alc.jpg'),
//                            filmData: 'Alc',
//                          ),
//                          FilmTile(
//                            image: AssetImage('assets/images/hox.jpg'),
//                            filmData: 'Hoc',
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                );
//              } else {
              return ListView(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10.0, height: 10.0),
                      Text.rich(
                        TextSpan(text: 'Top Picks For You'),
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
                            image: NetworkImage(
                                Uri.http(baseUrl, 'images/${film.imgUri}')
                                    .toString()),
                            filmData: film,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10.0, height: 10.0),
                      Text.rich(
                        TextSpan(text: 'Trending'),
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
                            image: NetworkImage(
                                Uri.http(baseUrl, 'images/${film.imgUri}')
                                    .toString()),
                            filmData: film,
                          );
                        },
                      ),
                    ),
                  ),    Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10.0, height: 10.0),
                      Text.rich(
                        TextSpan(text: 'Comedy'),
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
                            image: NetworkImage(
                                Uri.http(baseUrl, 'images/${film.imgUri}')
                                    .toString()),
                            filmData: film,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10.0, height: 10.0),
                      Text.rich(
                        TextSpan(text: 'Actions'),
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
                            image: NetworkImage(
                                Uri.http(baseUrl, 'images/${film.imgUri}')
                                    .toString()),
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
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to My List'),
        action: SnackBarAction(
            textColor: Colors.white54,
            label: 'OK',
            onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
