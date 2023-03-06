import 'package:flutter_movie_db/data/model/media.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'more_page_state.freezed.dart';

@freezed
class MorePageState with _$MorePageState{
  const factory MorePageState.moreLoaded({required List<Media> items}) = _MorePageState;
}
