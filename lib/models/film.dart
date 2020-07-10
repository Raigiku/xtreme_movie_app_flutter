class Film {
  int id;
  String title;
  String overview;
  bool favorite;

  Film(this.id, this.title, this.overview, this.favorite);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'favorite': favorite ? 1 : 0
    };
  }
}
