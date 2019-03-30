import 'package:flutter_movie_db/data/model/genre.dart';

class Media{
  final int vote_count;
  final int id;
  final String title;
  final String overview;
  final String release_date;
  final String poster_path;
  final String backdrop_path;
  final double vote_average;
  final MediaType type;
  final int runtime;
  final List<Genre> genres;


  Media({this.vote_count, this.id, this.title, this.overview,
      this.release_date,
    this.poster_path,
    this.vote_average,
    this.backdrop_path,
    this.runtime,
    this.genres,
    this.type});

  @override
  String toString() {
    return 'MediaModel{vote_count: $vote_count, id: $id, title: $title, overview: $overview, release_date: $release_date, poster_path: $poster_path}';
  }
}

enum MediaType{
  movie, tv
}