import 'package:flutter_movie_db/data/model/genre/genre.dart';
import 'package:json_annotation/json_annotation.dart';

part 'details_response.g.dart';

@JsonSerializable(includeIfNull: true)
class DetailsResponse {
  DetailsResponse({
    required this.id,
    required this.title,
    required this.name,
    required this.overview,
    required this.original_title,
    required this.release_date,
    required this.poster_path,
    required this.vote_average,
    required this.vote_count,
    required this.first_air_date,
    required this.popularity
  });

  bool? adult;
  String? backdrop_path;
  int? budget;
  String? homepage;
  int id;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String first_air_date;
  int? revenue;
  int? runtime;
  String? status;
  String title;
  String name;
  String? tagline;
  double vote_average;
  double popularity;
  int vote_count;
  List<Genre>? genres;

  factory DetailsResponse.fromJson(Map<String, dynamic> json) => _$DetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsResponseToJson(this);

  @override
  String toString() {
    return 'Details{id: $id, poster_path: $poster_path, title: $title, genres: ${genres.toString()}';
  }
}
