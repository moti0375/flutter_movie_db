import 'package:flutter_movie_db/data/model/media.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_page_state.freezed.dart';

@freezed
class DetailsPageState with _$DetailsPageState{
  const factory DetailsPageState.detailsLoaded({required Media details}) = _DetailsPageState;
}