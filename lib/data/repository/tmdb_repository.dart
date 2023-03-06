import 'dart:async';

import 'package:flutter_movie_db/application.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/data/model/movie_api_response/movie_api_response.dart';
import 'package:flutter_movie_db/data/model/tv_api_response/tv_api_response.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/data/model/details_response/details_response.dart';
import 'package:flutter_movie_db/network/retrofit_base_service.dart';

class TmdbRepository implements Repository {
  static const String IMAGES_BASE_URL = "https://image.tmdb.org/t/p/w500/";
  BaseRetrofitClient client;

  TmdbRepository({required this.client});

  // @override
  // Future<DetailsResponse> getMovieDetails(String id) async {
  //   print("tmdb service: getMovieDetails: $id");
  //   return client.getMovieDetails(id);
  // }

  @override
  Future<List<Media>> getTopRatedMovies() async {
    print("MvdbService: getMovies");
    dynamic response = await client.getTopRatedMovies(API_KEY);

    MovieApiResponse apiResponse = MovieApiResponse.fromJson(response);
    print("response: ${apiResponse.toString()}");

    return apiResponse.results
        .map((movie) => Media(
            id: movie.id,
            title: movie.title,
            vote_count: movie.voteCount,
            overview: movie.overview,
            poster_path: movie.posterPath,
            vote_average: movie.voteAverage,
            backdrop_path: movie.backdropPath,
            release_date: movie.releaseDate,
            genres: movie.genres,
            type: MediaType.movie))
        .toList();
  }

  @override
Future<List<Media>> getNowPlaying() async {
  print("getNowPlaying: called ");
  dynamic queryResult =
  await client.getNowPlaying(API_KEY).catchError((error) {
    print("Something went wrong: ${error.toString()}");
  });

  MovieApiResponse apiResponse = MovieApiResponse.fromJson(queryResult);

  print("getNowPlaying: done $apiResponse");
  return apiResponse.results.map((movie) {
    return Media(
        id: movie.id,
        title: movie.title,
        vote_count: movie.voteCount,
        overview: movie.overview,
        poster_path: movie.posterPath,
        vote_average: movie.voteAverage,
        backdrop_path: movie.backdropPath,
        release_date: movie.releaseDate,
        genres: movie.genres,
        type: MediaType.movie);
  }).toList();
}

  static String buildImageUrl(String imageName) {
    return "$IMAGES_BASE_URL/$imageName";
  }

  @override
Future<List<Media>> getPopularMovies() async {
  print("getPopularMovies: called ");
  dynamic queryResult =
  await client.getPopularMovies(API_KEY).catchError((error) {
    print("Error: ${error.toString()}");
  });

  print("getPopularMovies: done ");
  MovieApiResponse apiResponse = MovieApiResponse.fromJson(queryResult);

  return apiResponse.results.map((movie) {
    return Media(
        id: movie.id,
        title: movie.title,
        vote_count: movie.voteCount,
        overview: movie.overview,
        poster_path: movie.posterPath,
        vote_average: movie.voteAverage,
        backdrop_path: movie.backdropPath,
        release_date: movie.releaseDate,
        genres: movie.genres,
        type: MediaType.movie);
  }).toList();
}

@override
Future<List<Media>> getTopRatedTv() async {
  print("getTopRatedTv: called ");
  dynamic queryResult = await client.getTopRatedTv(API_KEY);
  print("getTopRatedTv: queryResult: $queryResult ");

  TvApiResponse apiResponse = TvApiResponse.fromJson(queryResult);

  return apiResponse.results.map((tv) {
    return Media(
        id: tv.id,
        title: tv.name,
        vote_count: tv.voteCount,
        overview: tv.overview,
        poster_path: tv.posterPath,
        vote_average: tv.voteAverage,
        backdrop_path: tv.backdropPath,
        release_date: tv.firstAirDate,
        type: MediaType.tv,
        genres: List.empty());
  }).toList();
}

@override
Future<Media> getMediaDetails(MediaType type, String id) async {
  print("getMediaDetails: type $type, id: $id");

  dynamic queryResponse = await client
      .getMediaDetails(API_KEY, type.toString().split(".").last, id)
      .catchError((error) {
    print("getMediaDetails: ${error.toString()}");
  });
  print("getMediaDetails: queryResponse $queryResponse");

  DetailsResponse response = DetailsResponse.fromJson(queryResponse);

  print("getMediaDetails:  DetailsResponse: ${response.toString()}");

  switch (type) {
    case MediaType.movie:
      Media media = Media(
          id: response.id,
          title: response.title,
          overview: response.overview,
          release_date: response.releaseDate,
          runtime: response.runtime,
          poster_path: response.posterPath,
          backdrop_path: response.backdropPath,
          vote_average: response.voteAverage,
          vote_count: response.voteCount,
          genres: response.genres,
          type: type);
      return media;
    case MediaType.tv:
      Media media = Media(
          id: response.id,
          title: response.name,
          overview: response.overview,
          release_date: response.firstAirDate,
          runtime: 0,
          poster_path: response.posterPath,
          backdrop_path: response.backdropPath,
          vote_average: response.popularity,
          vote_count: response.voteCount,
          genres: response.genres,
          type: type);
      return media;
  }
}


  @override
  Future<List<MediaModels>> getTopRatedMedias() {
    // TODO: implement getTopRatedMedias
    throw UnimplementedError();
  }


@override
Future<List<Media>> getMediaByCategory(MediaCategory category) {
  switch (category) {
    case MediaCategory.NowPlaying:
      return getNowPlaying();
    case MediaCategory.TopRated:
      return getTopRatedMovies();
    case MediaCategory.Popular:
      return getPopularMovies();
    case MediaCategory.TvShows:
      return getTopRatedTv();
  }
}


//

//
//
// @override
// Future<List<MediaModels>> getTopRatedMedias() async {
//   print("getTopRatedMedias: called");
//
//   List<MediaModels> items = List<MediaModels>();
//
//   ApiResponse apiResponse = await client.getTopRatedMovies();
//   print("getTopRatedMedias: after await");
//   List<Media> topRatedMovies = apiResponse.results.map((movie) {
//     return Media(
//         id: movie.id,
//         title: movie.title,
//         vote_count: movie.vote_count,
//         overview: movie.overview,
//         poster_path: movie.poster_path,
//         vote_average: movie.vote_average,
//         backdrop_path: movie.backdrop_path,
//         release_date: movie.release_date,
//         genres: movie.genres,
//         type: MediaType.movie);
//   }).toList();
//   items.add(MediaModels(items: topRatedMovies, title: "Top Rated Movies"));
//
//   ApiResponse tvResponse = await client.getTopRatedTv();
//   List<Media> topRatedTv = tvResponse.results.map((tv) {
//     return Media(
//         id: tv.id,
//         title: tv.name,
//         vote_count: tv.vote_count,
//         overview: tv.overview,
//         poster_path: tv.poster_path,
//         vote_average: tv.vote_average,
//         backdrop_path: tv.backdrop_path,
//         release_date: tv.first_air_date,
//         type: MediaType.tv,
//         genres: tv.genres);
//   }).toList();
//   items.add(MediaModels(items: topRatedTv, title: "Top Rated Tv"));
//
//   print("getTopRatedMedias: got ${items.length} items");
//   return items;
// }
//

//
}
