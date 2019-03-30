// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_http_client.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$AppApiClient implements ApiClient {
  final String basePath = "";
  Future<ApiResponse> getTopRatedMovies() async {
    var req = base.get.path(basePath).path("movie/top_rated");
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<DetailsResponse> getMovieDetails(String id) async {
    var req = base.get.path(basePath).path("movie/:id").pathParams("id", id);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<ApiResponse> getNowPlayingMovies() async {
    var req = base.get.path(basePath).path("movie/now_playing");
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<ApiResponse> getTopRatedTv() async {
    var req = base.get.path(basePath).path("tv/top_rated");
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<DetailsResponse> getMediaDetails(String type, String id) async {
    var req = base.get
        .path(basePath)
        .path(":type/:id")
        .pathParams("type", type)
        .pathParams("id", id);
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
