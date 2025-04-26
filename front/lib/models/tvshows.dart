/*************  ✨ Windsurf Command ⭐  *************/
class TVShowQuickType {
  int id;
  String name;
  String overview;
  List<int> genreIds;
  String posterPath;

  TVShowQuickType({
    required this.id,
    required this.name,
    required this.overview,
    required this.genreIds,
    required this.posterPath,
  });

  factory TVShowQuickType.fromJson(Map<String, dynamic> json) {
    return TVShowQuickType(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      genreIds: List<int>.from(json['genre_ids']),
      posterPath: json['poster_path'],
    );
  }
}
/*******  82a840b6-fef5-4355-8d4c-a7957d61e5af  *******/