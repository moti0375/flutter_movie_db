import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState{
  const factory HomePageState.nowPlayingLoaded({required MediaModels nowPlyaing}) = _NowPlayingLoaded;
  const factory HomePageState.topRatedLoaded({required MediaModels topRated}) = _TopRatedLoaded;
  const factory HomePageState.popularMoviesLoaded({required MediaModels popular}) = _PopularMoviesLoaded;
  const factory HomePageState.tvLoaded({required MediaModels tv}) = _TvLoaded;
}