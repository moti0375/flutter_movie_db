import 'dart:async';

import 'package:flutter_movie_db/bloc_cubit/base_cubit.dart';
import 'package:flutter_movie_db/bloc_cubit/base_state/base_bloc_state.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';

import './bloc.dart';

class HomePageBloc extends BaseCubit<HomePageState> {
  final Repository _repository;

  HomePageBloc(this._repository) : super(BaseBlocState.init()) ;

  void loadMovies() async {
    emit(BaseBlocState.loading());
    _loadNowPlaying();
    _loadPopular();
    _loadTopRated();
    _loadTv();
  }

  void _loadNowPlaying() async {
      List<Media> nowPlaying = await _repository.getNowPlaying();
      print("HomePageBloc: nowPlaying ${nowPlaying.toString()}");
      emit(BaseBlocState.next(HomePageState.nowPlayingLoaded(nowPlyaing: MediaModels(title: "Now Playing", items: nowPlaying))));
  }

  Future _loadPopular() async {
      List<Media> popularMovies = await _repository.getPopularMovies();
      emit(BaseBlocState.next(HomePageState.popularMoviesLoaded(popular: MediaModels(title: "Popular Movies", items: popularMovies))));
  }


  Future _loadTopRated() async {
    List<Media> topRated = await _repository.getTopRatedMovies();
    emit(BaseBlocState.next(HomePageState.topRatedLoaded(topRated: MediaModels(title: "Top Rated", items: topRated))));
  }

  Future _loadTv() async {
    List<Media> tvShows = await _repository.getTopRatedTv();
    emit(BaseBlocState.next(HomePageState.tvLoaded(tv: MediaModels(title: "Top Rated TV", items: tvShows))));
  }
}
