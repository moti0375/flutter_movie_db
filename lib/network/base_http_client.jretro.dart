// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_http_client.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$MovieApiClient implements ApiClient {
  final String basePath = "movie";
  Future<ApiResponse> getTopRatedMovies() async {
    var req = base.get.path(basePath).path("/top_rated");
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
