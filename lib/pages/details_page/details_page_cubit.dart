import 'package:flutter_movie_db/bloc_cubit/base_cubit.dart';
import 'package:flutter_movie_db/bloc_cubit/base_state/base_bloc_state.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/pages/details_page/details_page_state/details_page_state.dart';

class DetailsPageCubit extends BaseCubit<DetailsPageState>{
  final Repository _repository;
  final Media _media;
  DetailsPageCubit(this._repository, this._media) : super(BaseBlocState.init());

  void loadDetails() async {
    emit(BaseBlocState.loading());
    _repository.getMediaDetails(_media.type, _media.id.toString()).then((value) =>
      emit(BaseBlocState.next(DetailsPageState.detailsLoaded(details: value)))
    );
  }
}