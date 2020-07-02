import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/api/repo/film_repository.dart';
import 'package:netclick/components/shared/app_snackbar.dart';
import 'package:netclick/components/shared/film_tile.dart';
import 'package:netclick/components/shared/loading_indicatior.dart';
import 'package:netclick/models/film.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Film>> _futureDefaultFilmList;
  List<Film> _searchFilmList = [];
  TextEditingController _searchController;
  String _searchText = '';

  @override
  void initState() {
    _searchController = TextEditingController();
    _fetchFilm();
    super.initState();
  }

  void _onChangeSearchText(value) {
    this.setState(() {
      _searchText = _searchController.value.text;
      _searchFilmList = [];
    });
  }

  void _onSearch(String text) async {
    List<Film> tempSearchFilmList = await FilmRepository.getAllFilm(name: text);
    setState(() {
      _searchFilmList = tempSearchFilmList;
    });
  }

  void _fetchFilm() {
    try {
      this.setState(() {
        _futureDefaultFilmList = FilmRepository.getAllFilm();
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
        TextField(
          controller: _searchController,
          onChanged: _onChangeSearchText,
          onSubmitted: _onSearch,
          decoration: InputDecoration(
            hintText: 'Search for name of show',
            prefixIcon: Icon(Icons.search),
            fillColor: Colors.grey[900],
            filled: true,
          ),
        ),
        _searchText == '' ? _getDefaultSearchResult() : _getResult()
      ],
    );
  }

  Widget _getDefaultSearchResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 5),
          child: Text(
            'Popular Searches',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        Container(
          child: FutureBuilder<List<Film>>(
              future: _futureDefaultFilmList,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<Film> filmList = snapshot.data;
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
                      });
                }
                return LoadingIndicator();
              }),
        ),
      ],
    );
  }

  Widget _getResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 5),
          child: Text(
            'Result',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        Container(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _searchFilmList.length,
              itemBuilder: (BuildContext context, int index) {
                Film film = _searchFilmList[index];
                return FilmTile(
                  filmData: film,
                );
              }),
        ),
      ],
    );
  }
}
