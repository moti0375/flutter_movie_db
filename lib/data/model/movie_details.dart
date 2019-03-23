import 'package:json_annotation/json_annotation.dart';
part 'movie_details.g.dart';

@JsonSerializable(nullable: false)
class MovieDetails{

  MovieDetails();

  bool adult;
  String backdrop_path;
  int budget;
  String homepage;
  int id;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  int revenue;
  int runtime;
  String status;
  String title;
  String tagline;
  double vote_average;
  int vote_count;

  factory MovieDetails.fromJson(Map<String, dynamic> json) => _$MovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  @override
  String toString() {
    return 'MovieDetails{id: $id, poster_path: $poster_path, title: $title}';
  }


}