import 'package:equatable/equatable.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class InitialHomePageState extends HomePageState {}

class LoadingMovies extends HomePageState {}

class NowPlayingLoaded extends HomePageState {
  final MediaModels models;

  NowPlayingLoaded(this.models);

  @override
  List<Object> get props => [models];
}

class TopRatedLoaded extends HomePageState {
  final MediaModels models;

  TopRatedLoaded(this.models);

  @override
  List<Object> get props => [models];
}

class TvLoaded extends HomePageState {
  final MediaModels models;

  TvLoaded(this.models);

  @override
  List<Object> get props => [models];
}
