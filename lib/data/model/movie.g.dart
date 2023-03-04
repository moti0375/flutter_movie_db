// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      name: json['name'] as String?,
      overview: json['overview'] as String,
      vote_count: json['vote_count'] as int,
      poster_path: json['poster_path'] as String,
      vote_average: (json['vote_average'] as num).toDouble(),
      release_date: json['release_date'] as String,
      first_air_date: json['first_air_date'] as String?,
    )
      ..popularity = (json['popularity'] as num?)?.toDouble()
      ..original_language = json['original_language'] as String?
      ..original_title = json['original_title'] as String?
      ..backdrop_path = json['backdrop_path'] as String?
      ..adult = json['adult'] as bool?
      ..genres = (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'vote_count': instance.vote_count,
      'id': instance.id,
      'vote_average': instance.vote_average,
      'title': instance.title,
      'name': instance.name,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'backdrop_path': instance.backdrop_path,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.release_date,
      'first_air_date': instance.first_air_date,
      'genres': instance.genres,
    };
