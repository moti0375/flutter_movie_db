import 'package:equatable/equatable.dart';
import 'package:flutter_movie_db/data/model/media.dart';

abstract class MorePageState extends Equatable {
  const MorePageState();

  @override
  List<Object> get props => const [];
}

class InitialMorePageState extends MorePageState {}

class LoadingMore extends MorePageState {}

class MediaLoaded extends MorePageState {
  final List<Media> items;

  MediaLoaded({required this.items});

  @override
  List<Object> get props => [items];
}
