import 'package:flutter_movie_db/data/model/movie_details.dart';
import 'package:flutter_movie_db/network/response/api_response.dart';
import 'package:flutter_movie_db/network/response/api_response_serializer.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;
import 'dart:async';
import 'package:http/http.dart';

part 'base_http_client.jretro.dart';

@GenApiClient(path: "movie")
class MovieApi extends ApiClient with _$MovieApiClient {

  final String apiKey;
  final resty.Route base;
  MovieApi({this.base, this.apiKey}){
    final repo = JsonRepo()..add(ApiResponseJsonSerializer());
    repo..add(MovieJsonSerializer());
    repo..add(MovieDetailsJsonSerializer());

    globalClient = Client();
    this.jsonConverter = repo;
    this.base.before((r) {
      Map<String, dynamic> queries = r.getQuery;
      queries["api_key"] = apiKey;
      print("interceptor: ${queries.toString()}");
    });
  }

  @GetReq(path: "/top_rated")
  Future<ApiResponse> getTopRatedMovies();

  @GetReq(path: ":id")
  Future<MovieDetails> getMovieDetails(@PathParam() String id);

  @GetReq(path: "/now_playing")
  Future<ApiResponse> getNowPlayingMovies();

}