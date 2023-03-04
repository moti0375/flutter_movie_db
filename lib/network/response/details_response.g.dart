// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsResponse _$DetailsResponseFromJson(Map<String, dynamic> json) =>
    DetailsResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      name: json['name'] as String,
      overview: json['overview'] as String,
      original_title: json['original_title'] as String,
      release_date: json['release_date'] as String,
      poster_path: json['poster_path'] as String,
      vote_average: (json['vote_average'] as num).toDouble(),
      vote_count: json['vote_count'] as int,
      first_air_date: json['first_air_date'] as String,
      popularity: (json['popularity'] as num).toDouble(),
    )
      ..adult = json['adult'] as bool?
      ..backdrop_path = json['backdrop_path'] as String?
      ..budget = json['budget'] as int?
      ..homepage = json['homepage'] as String?
      ..revenue = json['revenue'] as int?
      ..runtime = json['runtime'] as int?
      ..status = json['status'] as String?
      ..tagline = json['tagline'] as String?
      ..genres = (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DetailsResponseToJson(DetailsResponse instance) =>
    <String, dynamic>{
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
      'genres': instance.genres,
    };
