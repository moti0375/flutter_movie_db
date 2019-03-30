// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
      results: (json['results'] as List)
          ?.map((e) =>
              e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
          ?.toList())
    ..page = json['page'] as int
    ..total_results = json['total_results'] as int
    ..total_pages = json['total_pages'] as int;
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.total_results,
      'total_pages': instance.total_pages,
      'results': instance.results
    };
