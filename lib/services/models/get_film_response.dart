class GetFilmResponse {
  int page;
  int totalResults;
  int totalPages;
  List<Results> results;

  GetFilmResponse(
      {this.page, this.totalResults, this.totalPages, this.results});

  GetFilmResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int id;
  String title;
  String overview;

  Results({
    this.id,
    this.title,
    this.overview,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    overview = json['overview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['overview'] = this.overview;
    return data;
  }
}
