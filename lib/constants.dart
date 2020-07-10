class Constants {
  static const apiKey = '3cae426b920b29ed2fb1c0749f258325';
  static String apiUrl(String filmName) {
    return 'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$filmName';
  }
}
