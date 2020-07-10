import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchFilmBar extends StatelessWidget {
  final void Function(String) _onChangeFilmName;
  final void Function() _onPressedSearchFilm;

  SearchFilmBar(
    this._onChangeFilmName,
    this._onPressedSearchFilm,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Titanic',
              labelText: 'Nombre de la película *',
            ),
            onChanged: _onChangeFilmName,
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: _onPressedSearchFilm,
        ),
      ],
    );
  }
}
