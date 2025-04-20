// lib/models/actor.dart

class Actor {
  final int id;
  final String name;
  final String? originalName;
  final String mediaType;
  final bool adult;
  final double popularity;
  final int gender;
  final String? knownForDepartment;
  final String? profilePath;

  Actor({
    required this.id,
    required this.name,
    this.originalName,
    required this.mediaType,
    required this.adult,
    required this.popularity,
    required this.gender,
    this.knownForDepartment,
    this.profilePath,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        mediaType: json["media_type"],
        adult: json["adult"],
        popularity: (json["popularity"] as num).toDouble(),
        gender: json["gender"],
        knownForDepartment: json["known_for_department"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "original_name": originalName,
        "media_type": mediaType,
        "adult": adult,
        "popularity": popularity,
        "gender": gender,
        "known_for_department": knownForDepartment,
        "profile_path": profilePath,
      };
}
