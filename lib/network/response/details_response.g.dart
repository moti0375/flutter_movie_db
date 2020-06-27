// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsResponse _$DetailsResponseFromJson(Map<String, dynamic> json) {
  return DetailsResponse()
    ..adult = json['adult'] as bool
    ..backdrop_path = json['backdrop_path'] as String
    ..budget = json['budget'] as int
    ..homepage = json['homepage'] as String
    ..id = json['id'] as int
    ..original_title = json['original_title'] as String
    ..overview = json['overview'] as String
    ..poster_path = json['poster_path'] as String
    ..release_date = json['release_date'] as String
    ..first_air_date = json['first_air_date'] as String
    ..revenue = json['revenue'] as int
    ..runtime = json['runtime'] as int
    ..status = json['status'] as String
    ..title = json['title'] as String
    ..name = json['name'] as String
    ..tagline = json['tagline'] as String
    ..vote_average = (json['vote_average'] as num)?.toDouble()
    ..popularity = (json['popularity'] as num)?.toDouble()
    ..vote_count = json['vote_count'] as int
    ..genres = (json['genres'] as List)?.map((e) => e == null ? null : Genre.fromJson(e as Map<String, dynamic>))?.toList();
}

Map<String, dynamic> _$DetailsResponseToJson(DetailsResponse instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'budget': instance.budget,
      'homepage': instance.homepage,
      'id': instance.id,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'poster_path': instance.poster_path,
      'release_date': instance.release_date,
      'first_air_date': instance.first_air_date,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'status': instance.status,
      'title': instance.title,
      'name': instance.name,
      'tagline': instance.tagline,
      'vote_average': instance.vote_average,
      'popularity': instance.popularity,
      'vote_count': instance.vote_count,
      'genres': instance.genres
    };
