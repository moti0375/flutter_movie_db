import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => const [];
}

class LoadMovies extends HomePageEvent {}
class LoadNowPlaying extends HomePageEvent {}
class LoadTopRated extends HomePageEvent {}
class LoadMostPopular extends HomePageEvent {}
class LoadTv extends HomePageEvent {}

