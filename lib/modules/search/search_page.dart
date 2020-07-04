import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xtreme_movie_app/models/film.dart';
import 'package:xtreme_movie_app/services/film_service.dart';
import 'package:xtreme_movie_app/services/models/get_film_response.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _filmName = '';
  Future<GetFilmResponse> _getFilmResponse;
  List<Film> _films = [];

  void _filmNameChanged(String name) {
    setState(() {
      _filmName = name;
    });
  }

  void _searchFilm() {
    final futureResponse = FilmService.getFilm(_filmName);
    futureResponse.then((response) => {_filmsLoadedFromApi(response)});
    setState(() {
      _getFilmResponse = futureResponse;
    });
  }

  void _filmsLoadedFromApi(GetFilmResponse response) {
    setState(() {
      _films = response.results
          .map((e) => Film(e.title, e.overview, false))
          .toList();
    });
  }

  void Function() _makeFilmFavorite(Film film) {
    final filmIndex = _films.indexOf(film);
    return () {
      setState(() {
        _films = [
          ..._films.getRange(0, filmIndex),
          Film(film.title, film.overview, !film.favorite),
          ..._films.getRange(filmIndex + 1, _films.length),
        ];
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 15,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Titanic',
                    labelText: 'Nombre de la película *',
                  ),
                  onChanged: _filmNameChanged,
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _searchFilm,
              ),
            ],
          ),
          FutureBuilder<GetFilmResponse>(
            future: _getFilmResponse,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Expanded(
                    child: ListView(
                        children: _films
                            .map((film) => Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              leading: Icon(Icons.movie),
                                              title: Text('${film.title}'),
                                              subtitle:
                                                  Text('${film.overview}'),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(film.favorite
                                                ? Icons.favorite
                                                : Icons.favorite_border),
                                            onPressed: _makeFilmFavorite(film),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                            .toList()),
                  );
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
