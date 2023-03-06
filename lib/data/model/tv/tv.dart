import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv.g.dart';
part 'tv.freezed.dart';

@freezed
class Tv with _$Tv{
  const factory Tv({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'popularity')  double? popularity,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'overview') required String overview,
    @JsonKey(name: 'first_air_date')  String? firstAirDate,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'vote_average') required double voteAverage,
  }) = _Tv;

  factory Tv.fromJson(Map<String, Object?> json) => _$TvFromJson(json);

}