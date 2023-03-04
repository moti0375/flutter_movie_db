import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';

import './bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final Repository _repository;

  HomePageBloc(this._repository) : super(InitialHomePageState()) {
    on<LoadMovies>((event, emit) async {
      emit(LoadingMovies());
       add(LoadNowPlaying());
       add(LoadTopRated());
       add(LoadMostPopular());
       add(LoadTv());
    });
    on<LoadNowPlaying>((event, emit) async {
      await _loadNowPlaying(emit);
    });

    on<LoadTopRated>((event, emit) async {
      await _loadTopRated(emit);
    });

    on<LoadTv>((event, emit) async {
      await _loadTv(emit);
    });

    on<LoadMostPopular>((event, emit) async {
      await _loadPopular(emit);
    });
  }

  Future _loadNowPlaying(Emitter<HomePageState> emit) async {
      List<Media> nowPlaying = await _repository.getNowPlaying();
      print("HomePageBloc: nowPlaying ${nowPlaying.toString()}");
      emit(NowPlayingLoaded(MediaModels(title: "Now Playing", items: nowPlaying)));
  }

  Future _loadPopular(Emitter<HomePageState> emit) async {
      List<Media> popularMovies = await _repository.getPopularMovies();
      emit(PopularMoviesLoaded(MediaModels(title: "Popular Movies", items: popularMovies)));
  }


  Future _loadTopRated(Emitter<HomePageState> emit) async {
    List<Media> topRated = await _repository.getTopRatedMovies();
    emit(TopRatedLoaded(MediaModels(title: "Top Rated", items: topRated)));
  }

  Future _loadTv(Emitter<HomePageState> emit) async {
    List<Media> tvShows = await _repository.getTopRatedTv();
    emit(TvLoaded(MediaModels(title: "Top Rated TV", items: tvShows)));
  }
}
