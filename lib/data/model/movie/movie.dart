import 'package:flutter_movie_db/data/model/genre/genre.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.g.dart';
part 'movie.freezed.dart';

@freezed
class Movie with _$Movie{
  const factory Movie({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'popularity')  double? popularity,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'adult') bool? adult,
    @JsonKey(name: 'overview') required String overview,
    @JsonKey(name: 'release_date') required String releaseDate,
    @JsonKey(name: 'first_air_date')  String? firstAirDate,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'genres') List<Genre>? genres
  }) = _Movie;

  factory Movie.fromJson(Map<String, Object?> json) => _$MovieFromJson(json);

}
