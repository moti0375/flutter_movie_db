import 'dart:async';

import 'package:flutter_movie_db/network/response/api_response.dart';
import 'package:flutter_movie_db/network/response/details_response.dart';
class AppApi  {

  //final String apiKey;
  // final resty.Route base;

  // AppApi({this.base, this.apiKey}){
  //   final repo = JsonRepo()..add(ApiResponseJsonSerializer());
  //   repo..add(MovieJsonSerializer());
  //   repo..add(MovieDetailsJsonSerializer());
  //   repo..add(GenereJsonSerializer());
  //
  //   globalClient = Client();
  //   this.jsonConverter = repo;
  //   this.base.before((r) {
  //     Map<String, dynamic> queries = r.getQuery;
  //     queries["api_key"] = apiKey;
  //     print("interceptor: ${queries.toString()}");
  //   });
  // }

  // @GetReq(path: "movie/top_rated")
  // Future<ApiResponse> getTopRatedMovies();
  //
  // @GetReq(path: "movie/:id")
  // Future<DetailsResponse> getMovieDetails(@PathParam() String id);
  //
  // @GetReq(path: "movie/now_playing")
  // Future<ApiResponse> getNowPlayingMovies();
  //
  // @GetReq(path: "movie/popular")
  // Future<ApiResponse> getPopularMovies();
  //
  // @GetReq(path: "tv/top_rated")
  // Future<ApiResponse> getTopRatedTv();
  //
  // @GetReq(path: ":type/:id")
  // Future<DetailsResponse> getMediaDetails(@PathParam() String type, @PathParam() String id);
}