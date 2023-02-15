import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';

import './bloc.dart';

class MorePageBloc extends Bloc<MorePageEvent, MorePageState> {
  final BaseRepository _repository;
  final MediaCategory _category;

  MorePageBloc(this._repository, this._category);

  @override
  MorePageState get initialState => InitialMorePageState();

  @override
  Stream<MorePageState> mapEventToState(MorePageEvent event) async* {
    print("mapEventToState: $event, $_category");
    if (event is LoadMoreEvent) {
      print("mapEventToState: $event");
      yield* _loadMedias();
    }
  }

  Stream<MorePageState> _loadMedias() async* {
    print("_loadMedias: ");

    yield LoadingMore();
    List<Media> results = await _repository.getMediaByCategory(_category);
    print("results: $results");
    yield MediaLoaded(items: results);
  }
}
