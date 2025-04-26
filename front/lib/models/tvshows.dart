// To parse this JSON data, do
//
//     final series = seriesFromJson(jsonString);

import 'dart:convert';

SeriesResponse seriesFromJson(String str) => SeriesResponse.fromJson(json.decode(str));

String seriesToJson(SeriesResponse data) => json.encode(data.toJson());

class SeriesResponse {
    String msg;
    List<Series> data;

    SeriesResponse({
        required this.msg,
        required this.data,
    });

    factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
        msg: json["msg"],
        data: List<Series>.from(json["data"].map((x) => Series.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Series {
    String backdropPath;
    int id;
    String name;
    String originalName;
    String overview;
    String posterPath;
    String mediaType;
    bool adult;
    String originalLanguage;
    List<int> genreIds;
    double popularity;
    DateTime firstAirDate;
    double voteAverage;
    int voteCount;
    List<String> originCountry;

    Series({
        required this.backdropPath,
        required this.id,
        required this.name,
        required this.originalName,
        required this.overview,
        required this.posterPath,
        required this.mediaType,
        required this.adult,
        required this.originalLanguage,
        required this.genreIds,
        required this.popularity,
        required this.firstAirDate,
        required this.voteAverage,
        required this.voteCount,
        required this.originCountry,
    });

    factory Series.fromJson(Map<String, dynamic> json) => Series(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        adult: json["adult"],
        originalLanguage: json["original_language"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "adult": adult,
        "original_language": originalLanguage,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    };
}
