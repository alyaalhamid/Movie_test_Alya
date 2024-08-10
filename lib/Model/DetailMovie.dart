/// [detaildiscmovie] merupakan model yang di dapatkan dari response API, model ini di wajibkan ada di setiap API
class detaildiscmovie {
  bool? adult;
  String? backdropPath;
  int? budget;
  List<dynamic>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  int? revenue;
  int? runtime;
  List<dynamic>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  detaildiscmovie({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory detaildiscmovie.fromJson(Map<String, dynamic> json) {
    return detaildiscmovie(
      adult: json['adult'],
      backdropPath: json['backdropPath'],
      budget: json['budget'],
      genres: json['genres'],
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdbId'],
      originalLanguage: json['originalLanguage'],
      originalTitle: json['originalTitle'],
      overview: json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['posterPath'],
      releaseDate: DateTime.tryParse(json['release_date'] ?? ''),
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: json['spokenLanguages'],
      status: json['status'],
      title: json['title'],
      tagline: json['tagline'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['voteCount'],
    );
  }
}
