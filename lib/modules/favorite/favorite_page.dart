import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtreme_movie_app/models/film.dart';
import 'package:xtreme_movie_app/modules/search/components/film_list_view.dart';
import 'package:xtreme_movie_app/repositories/film_repository.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<List<Film>> _films;

  void Function() _onPressedAddRemoveFavoriteFilm(Film film) {
    return () {
      FilmRepository.deleteById(film.id);
      setState(() {
        _films = FilmRepository.getAll();
      });
    };
  }

  @override
  void initState() {
    super.initState();
    _films = FilmRepository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          FutureBuilder<List<Film>>(
            future: _films,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return FilmListView(
                      snapshot.data, _onPressedAddRemoveFavoriteFilm);
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
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
