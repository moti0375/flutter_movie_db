import 'package:flutter_movie_db/data/model/tv/tv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv_api_response.freezed.dart';
part 'tv_api_response.g.dart';

@freezed
class TvApiResponse with _$TvApiResponse {

  const factory TvApiResponse({
    required List<Tv> results,
    int? page,
    int? totalResults,
    int? totalPages
  }) = _TvApiResponse;

  factory TvApiResponse.fromJson(Map<String, Object?> json) => _$TvApiResponseFromJson(json);


}