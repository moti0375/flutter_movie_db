import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';

import './bloc.dart';

class MorePageBloc extends Bloc<MorePageEvent, MorePageState> {
  final Repository _repository;
  final MediaCategory _category;

  MorePageBloc(this._repository, this._category) : super(InitialMorePageState()){
    on<LoadMoreEvent>((event, emit) async {
      emit(LoadingMore());
      await _loadMedias(emit);
    });
  }

  Future _loadMedias(Emitter<MorePageState> emit) async {
    print("_loadMedias: ");
    List<Media> results = await _repository.getMediaByCategory(_category);
    print("results: $results");
    emit( MediaLoaded(items: results));
  }
}
