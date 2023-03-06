import 'package:flutter_movie_db/data/model/genre/genre.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'details_response.g.dart';
part 'details_response.freezed.dart';

@freezed
class DetailsResponse with _$DetailsResponse{
 const factory DetailsResponse({
   @JsonKey(name: 'id') required int id,
   @JsonKey(name: 'adult') bool? adult,
   @JsonKey(name: 'backdrop_path') String? backdropPath,
   @JsonKey(name: 'budget') int? budget,
   @JsonKey(name: 'homepage') String? homepage,
   @JsonKey(name: 'original_title') String? originalTitle,
   @JsonKey(name: 'overview') required String overview,
   @JsonKey(name: 'poster_path') required String posterPath,
   @JsonKey(name: 'release_date') String? releaseDate,
   @JsonKey(name: 'first_air_date') String? firstAirDate,
   @JsonKey(name: 'revenue') int? revenue,
   @JsonKey(name: 'runtime') int? runtime,
   @JsonKey(name: 'status') String? status,
   @JsonKey(name: 'title') @Default("") String title,
   @JsonKey(name: 'name') @Default("") String name,
   @JsonKey(name: 'tagline') String? tagline,
   @JsonKey(name: 'vote_average') required double voteAverage,
   @JsonKey(name: 'popularity') required double popularity,
   @JsonKey(name: 'vote_count') required int voteCount,
   @JsonKey(name: 'genres') List<Genre>? genres,
  }) = _DetailsResponse;



  factory DetailsResponse.fromJson(Map<String, Object?> json) => _$DetailsResponseFromJson(json);
}
