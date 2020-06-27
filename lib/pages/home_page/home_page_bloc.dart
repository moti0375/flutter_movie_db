import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';

import './bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final BaseRepository _repository;

  HomePageBloc(this._repository);

  @override
  HomePageState get initialState => InitialHomePageState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is LoadMovies) {
      yield* _loadMoviesFromApi();
    }
  }

  Stream<HomePageState> _loadMoviesFromApi() async* {
    yield LoadingMovies();
    try {
      List<Media> nowPlaying = await _repository.getNowPlaying();
      print("_loadMoviesFromApi: nowPlaying ${nowPlaying.toString()}");
      yield NowPlayingLoaded(MediaModels(title: "Now Playing", items: nowPlaying));
      List<Media> topRated = await _repository.getTopRatedMovies();
      yield TopRatedLoaded(MediaModels(title: "Top Rated", items: topRated));

      List<Media> popularMovies = await _repository.getPopularMovies();
      yield PopularMoviesLoaded(MediaModels(title: "Popular Movies", items: popularMovies));

      List<Media> tvShows = await _repository.getTopRatedTv();
      yield TvLoaded(MediaModels(title: "Top Rated TV", items: tvShows));
    } catch (e, stacktrace) {
      print("There was an error: ${stacktrace.toString()}");
    }
  }
}
