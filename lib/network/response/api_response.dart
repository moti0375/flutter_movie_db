import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse{
  ApiResponse({required this.results});
  int? page, total_results, total_pages;
  List<Movie> results;


  @override
  String toString() {
    return 'ApiResponse{page: $page, total_results: $total_results, total_pages: $total_pages, results: $results}';
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
