import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtreme_movie_app/models/film.dart';

class FilmListView extends StatelessWidget {
  final List<Film> _films;
  final void Function() Function(Film) _onPressedAddRemoveFavoriteFilm;

  FilmListView(
    this._films,
    this._onPressedAddRemoveFavoriteFilm,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: _films
            .map(
              (film) => Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Icon(Icons.movie),
                            title: Text('${film.title}'),
                            subtitle: Text('${film.overview}'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(film.favorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: _onPressedAddRemoveFavoriteFilm(film),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
