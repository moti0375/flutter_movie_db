import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie_db/bloc_cubit/base_cubit.dart';
import 'package:flutter_movie_db/bloc_cubit/base_state/base_bloc_state.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';

import './bloc.dart';

class MorePageBloc extends BaseCubit<MorePageState> {
  final Repository _repository;
  final MediaCategory _category;

  MorePageBloc(this._repository, this._category) : super(BaseBlocState.init());

  void loadMedias() async {
    print("_loadMedias: ");
    emit(BaseBlocState.loading());
    List<Media> items = await _repository.getMediaByCategory(_category);
    print("results: $items");
    emit( BaseBlocState.next(MorePageState.moreLoaded(items: items)));
  }
}
