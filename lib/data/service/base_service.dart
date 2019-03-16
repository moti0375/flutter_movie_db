import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/model/movie_details.dart';


abstract class BaseService{
  Future<List<Movie>> getTopRatedMovies();
  Future<MovieDetails> getMovieDetails(String id);
  Future<List<Movie>> getNowPlaying();
}


class MockService implements BaseService{
  @override
  Future<MovieDetails> getMovieDetails(String id) {
    return null;
  }

  @override
  Future<List<Movie>> getTopRatedMovies() {
    print("MockService: getMovies");
    Movie movie1 = Movie();
    movie1.title = "Back To The Future";
    movie1.overview = "Cool movie!";
    movie1.poster_path = "https://upload.wikimedia.org/wikipedia/en/thumb/d/d2/Back_to_the_Future.jpg/220px-Back_to_the_Future.jpg";

    Movie movie2 = Movie();
    movie2.title =  "Back to The Future2";
    movie2.poster_path =  "https://no666.files.wordpress.com/2015/01/back-to-the-future.jpg";
    movie2.overview =  "Greate iconic movie";


    Movie movie3 = Movie();
    movie3.title =  "Back to The Future3";
    movie3.poster_path =  "https://cdn.shopify.com/s/files/1/0799/0083/products/BackToTheFuture3Deluxe_grande.jpg";
    movie3.overview =  "Greate iconic movie";

    List<Movie> movies = [movie1, movie2, movie3];
    Future<List<Movie>> result = new Future.delayed(Duration(milliseconds: 500), () => movies);
    return result;
  }

  @override
  Future<List<Movie>> getNowPlaying() {
    return null;
  }

}