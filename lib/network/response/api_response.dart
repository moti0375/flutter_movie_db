import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_response.g.dart';

@JsonSerializable(nullable: false)
class ApiResponse{
  ApiResponse({this.results});
  int page;
  int total_results;
  int total_pages;
  List<Movie> results;


  @override
  String toString() {
    return 'ApiResponse{page: $page, total_results: $total_results, total_pages: $total_pages, results: $results}';
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
