import 'package:flutter_movie_db/data/model/movie/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'movie_api_response.g.dart';
part 'movie_api_response.freezed.dart';

@freezed
class MovieApiResponse with _$MovieApiResponse {
  const factory MovieApiResponse({
    required List<Movie> results,
    int? page,
    int? totalResults,
    int? totalPages
  }) = _MovieApiResponse;


  factory MovieApiResponse.fromJson(Map<String, Object?> json) => _$MovieApiResponseFromJson(json);
}
