import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xtreme_movie_app/constants.dart';
import 'models/get_film_response.dart';

class FilmService {
  static Future<GetFilmResponse> getFilm(String name) async {
    final apiUrl = Constants.apiUrl(name);
    final response = await http.get(apiUrl);
    return GetFilmResponse.fromJson(json.decode(response.body));
  }
}
