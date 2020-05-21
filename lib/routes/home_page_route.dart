import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netclick/components/shared/detail_page.dart';
import 'package:netclick/components/shared/film_tile.dart';
import 'package:netclick/models/app_state.dart';
import 'package:netclick/redux/actions.dart';

class HomepageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme
            .of(context)
            .backgroundColor,
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
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
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
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        child: Icon(Icons.cast, color: Colors.white),
//        backgroundColor: Color.fromRGBO(105, 105, 105, 1),
//        tooltip: 'Casting',

//      ),
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
          //  Todo setup the controller
          controller: controller,
          onTap: _onTapTabBar,
        ),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 10.0, height: 10.0),
                Text.rich(
                  TextSpan(text: 'Continue watching for Ram'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat'),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              height: 240.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  FilmTile(
                    image: AssetImage('assets/images/ghoul.jpg'),
                    filmData: 'Ghl',
                  ),
                  FilmTile(
                    image: AssetImage('assets/images/alc.jpg'),
                    filmData: 'Alc',
                  ),
                ],
              ),
            ),
            new Row(
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
              margin: EdgeInsets.symmetric(vertical: 5.0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  FilmTile(
                    image: AssetImage('assets/images/ghoul.jpg'),
                    filmData: 'Ghl',
                  ),
                  FilmTile(
                    image: AssetImage('assets/images/alc.jpg'),
                    filmData: 'Alc',
                  ),
                  FilmTile(
                    image: AssetImage('assets/images/hox.jpg'),
                    filmData: 'Hoc',
                  ),
                ],
              ),
            ),
          ],
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
