import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
import 'package:flutter_movie_db/network/base_http_client.dart';
import 'package:flutter_movie_db/network/response/api_response.dart';
import 'package:flutter_movie_db/network/response/details_response.dart';
import 'dart:async';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:http/http.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

class TmdbService implements BaseService {
  static const String BASE_URI = "https://api.themoviedb.org/3/";
  static const String IMAGES_BASE_URL = "https://image.tmdb.org/t/p/w500/";
  static const String API_KEY = "b331218ddcbd128634135abf7673fab5";
  final repo = JsonRepo()..add;
  final AppApi client = AppApi(base: route(BASE_URI), apiKey: API_KEY)
    ..jsonConverter;

  @override
  Stream<DetailsResponse> getMovieDetails(String id) async* {
    print("tmdb service: getMovieDetails: $id");
    DetailsResponse details = await client.getMovieDetails(id);
    yield details;
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    // print("MvdbService: getMovies");

    ApiResponse response = await client.getTopRatedMovies();

    // print("response: ${response.toString()}" );
    return response.results;
  }

  static String buildImageUrl(String imageName) {
    return "$IMAGES_BASE_URL/$imageName";
  }

  @override
  Stream<List<Media>> getNowPlaying() async* {
    print("getNowPlaying: called ");
    ApiResponse eventStream =
        await client.getNowPlayingMovies().catchError((error) {
      print("Error: ${error.toString()}");
    });
    print("getNowPlaying: done ");
    List<Media> models = eventStream.results.map((movie) {
      return Media(
          id: movie.id,
          title: movie.title,
          vote_count: movie.vote_count,
          overview: movie.overview,
          poster_path: movie.poster_path,
          vote_average: movie.vote_average,
          backdrop_path: movie.backdrop_path,
          release_date: movie.release_date,
          genres: movie.genres,
          type: MediaType.movie);
    }).toList();
    print("getNowPlaying: after ${models.length} media items");
    yield models;
  }

  @override
  Stream<List<Media>> getTopRatedTv() async* {
    print("getTopRatedTv: called ");
    ApiResponse response = await client.getTopRatedTv();
    List<Media> medias = response.results.map((tv) {
      return Media(
          id: tv.id,
          title: tv.name,
          vote_count: tv.vote_count,
          overview: tv.overview,
          poster_path: tv.poster_path,
          vote_average: tv.vote_average,
          backdrop_path: tv.backdrop_path,
          release_date: tv.first_air_date,
          type: MediaType.tv,
          genres: tv.genres);
    }).toList();
    yield medias;
  }

  @override
  Stream<Media> getMediaDetails(MediaType type, String id) async* {
    DetailsResponse response = await client
        .getMediaDetails(type.toString().split(".").last, id)
        .catchError((error) {
      print("getMediaDetails: ${error.toString()}");
    });

    print("getMediaDetails: ${response.toString()}");

    switch (type) {
      case MediaType.movie:
        Media media = Media(
            id: response.id,
            title: response.title,
            overview: response.overview,
            release_date: response.release_date,
            runtime: response.runtime,
            poster_path: response.poster_path,
            backdrop_path: response.backdrop_path,
            vote_average: response.vote_average,
            vote_count: response.vote_count,
            genres: response.genres,
            type: type);
        yield media;
        break;
      case MediaType.tv:
        Media media = Media(
            id: response.id,
            title: response.name,
            overview: response.overview,
            release_date: response.first_air_date,
            runtime: 0,
            poster_path: response.poster_path,
            backdrop_path: response.backdrop_path,
            vote_average: response.popularity,
            vote_count: response.vote_count,
            genres: response.genres,
            type: type);
        yield media;
        break;
    }
  }
}
