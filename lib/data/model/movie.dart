import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';


@JsonSerializable(nullable: false)
class Movie{

  Movie();
  int vote_count;
  int id;
  double vote_average;
  String title;
  double popularity;
  String poster_path;
  String original_language;
  String original_title;
  String backdrop_path;
  bool adult;
  String overview;
  String release_date;

  @override
  String toString() {
    return 'Movie{vote_count: $vote_count, id: $id, vote_average: $vote_average, title: $title, popularity: $popularity, poster_path: $poster_path, original_language: $original_language, original_title: $original_title, backdrop_path: $backdrop_path, adult: $adult, overview: $overview, release_date: $release_date}';
  }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

}