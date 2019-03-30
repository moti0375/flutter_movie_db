import 'package:flutter_movie_db/data/model/genre.dart';
import 'package:json_annotation/json_annotation.dart';
part 'details_response.g.dart';

@JsonSerializable(nullable: true, includeIfNull: true)
class DetailsResponse{

  DetailsResponse();

  bool adult;
  String backdrop_path;
  int budget;
  String homepage;
  int id;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String first_air_date;
  int revenue;
  int runtime;
  String status;
  String title;
  String name;
  String tagline;
  double vote_average;
  double popularity;
  int vote_count;
  List<Genre> genres;

  factory DetailsResponse.fromJson(Map<String, dynamic> json) => _$DetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsResponseToJson(this);

  @override
  String toString() {
    return 'Details{id: $id, poster_path: $poster_path, title: $title, genres: ${genres.toString()}';
  }


}