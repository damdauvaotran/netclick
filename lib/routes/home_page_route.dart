import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netclick/components/shared/detail_page.dart';
import 'package:netclick/components/shared/film_tile.dart';

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

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.cast, color: Colors.white),
        backgroundColor: Color.fromRGBO(105, 105, 105, 1),
        tooltip: 'Cast to Screen',
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
                  FilmTile(image: AssetImage('assets/images/ghoul.jpg')),
                  FilmTile(image: AssetImage('assets/images/str2.jpg')),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(data: 'Ghl')),
                      );
                    },
                    child: Container(
                      child: Image.asset('assets/images/ghoul.jpg'),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: 130.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(data: 'Alc')),
                      );
                    },
                    child: Container(
                      child: Image.asset('assets/images/alc.jpg'),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: 130.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(data: 'Hoc')),
                      );
                    },
                    child: Container(
                      child: Image.asset('assets/images/hox.jpg'),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: 130.0,
                    ),
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
