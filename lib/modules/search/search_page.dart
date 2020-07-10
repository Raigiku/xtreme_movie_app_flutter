import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtreme_movie_app/models/film.dart';
import 'package:xtreme_movie_app/repositories/film_repository.dart';
import 'package:xtreme_movie_app/services/film_service.dart';
import 'package:xtreme_movie_app/services/models/get_film_response.dart';

import 'components/film_list_view.dart';
import 'components/search_film_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _filmName = '';
  List<Film> _films = [];
  Future<GetFilmResponse> _futureGetFilmResponse;

  void _filmNameChanged(String name) {
    setState(() {
      _filmName = name;
    });
  }

  void _searchFilm() {
    final futureResponse = FilmService.getFilm(_filmName);
    futureResponse.then((response) => {_filmsLoadedFromApi(response)});
    setState(() {
      _futureGetFilmResponse = futureResponse;
    });
  }

  void _filmsLoadedFromApi(GetFilmResponse response) async {
    final filmsFromApi = response.results
        .map((e) => Film(e.id, e.title, e.overview, false))
        .toList();

    final savedFilms = await FilmRepository.getAll();

    final newFilms = filmsFromApi.map((film) {
      for (var savedFilm in savedFilms) {
        if (savedFilm.id == film.id) {
          return Film(film.id, film.title, film.overview, true);
        }
      }
      return film;
    }).toList();
    setState(() {
      _films = newFilms;
    });
  }

  void Function() _makeFilmFavorite(Film film) {
    return () {
      final updatedFilm = Film(
        film.id,
        film.title,
        film.overview,
        !film.favorite,
      );

      if (!film.favorite) {
        FilmRepository.insert(updatedFilm);
      } else {
        FilmRepository.deleteById(film.id);
      }

      final filmIndex = _films.indexOf(film);
      setState(() {
        _films = [
          ..._films.getRange(0, filmIndex),
          updatedFilm,
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
          SearchFilmBar(_filmNameChanged, _searchFilm),
          FutureBuilder<GetFilmResponse>(
            future: _futureGetFilmResponse,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return FilmListView(_films, _makeFilmFavorite);
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
