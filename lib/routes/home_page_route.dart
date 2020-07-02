import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/api/repo/film_repository.dart';
import 'package:netclick/components/home/home_screen.dart';
import 'package:netclick/components/search/search_screen.dart';
import 'package:netclick/components/shared/app_snackbar.dart';
import 'package:netclick/components/shared/film_tile.dart';
import 'package:netclick/models/app_state.dart';
import 'package:netclick/models/film.dart';
import 'package:netclick/redux/actions.dart';
import 'package:netclick/components/favorite_list/list_screen.dart';

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
  TabController _tabController;
  Future<List<Film>> _futureFilmList;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    _tabController = new TabController(length: 4, vsync: this);
    _futureFilmList = FilmRepository.getAllFilm();
  }

  _onTapTabBar(int index) {
    if (index == 3) {
      _logOut();
    }
  }

  void _logOut() {
    StoreProvider.of<AppState>(context).dispatch(UpdateToken(token: ''));
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
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
            Tab(
              icon: Icon(Icons.favorite),
              child: Text('Favorite'),
            ),
            new Tab(
              icon: new Icon(Icons.power_settings_new),
              child: Text('Logout'),
            ),
          ],
          controller: _tabController,
          onTap: _onTapTabBar,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            child: HomeScreen(),
          ),
          Container(
            child: SearchScreen(),
          ),
          // Not show anything, for logout propose
          Container(
            child: ListScreen(),
          ),
          Container(),
        ],
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
