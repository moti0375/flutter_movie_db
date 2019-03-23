
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/model/movie_details.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
import 'package:flutter_movie_db/network/base_http_client.dart';
import 'package:flutter_movie_db/network/response/api_response.dart';
import 'dart:async';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:http/http.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';


class TmdbService implements BaseService{

  static const String BASE_URI = "https://api.themoviedb.org/3/";
  static const String IMAGES_BASE_URL = "https://image.tmdb.org/t/p/w500/";
  static const String API_KEY = "b331218ddcbd128634135abf7673fab5";
  final repo = JsonRepo()..add;
  final MovieApi client = MovieApi(base: route(BASE_URI), apiKey: API_KEY)..jsonConverter;

  @override
  Stream<MovieDetails> getMovieDetails(String id) async* {
    print("tmdb service: getMovieDetails: $id");
    MovieDetails details = await client.getMovieDetails(id);
    yield details;
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
   // print("MvdbService: getMovies");

    ApiResponse response = await client.getTopRatedMovies();
   // print("response: ${response.toString()}" );
    return response.results;
  }


  static String buildImageUrl(String imageName){
    return "$IMAGES_BASE_URL/$imageName";
  }

  @override
  Stream<List<Movie>> getNowPlaying() async* {
    ApiResponse eventStream = await client.getNowPlayingMovies();
    yield eventStream.results;
  }



}