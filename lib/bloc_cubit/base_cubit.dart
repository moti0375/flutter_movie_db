import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/bloc_cubit/base_state/base_bloc_state.dart';

abstract class BaseCubit<S> extends Cubit<BaseBlocState<S>>{
  BaseCubit(super.initialState);
}