import 'package:equatable/equatable.dart';

abstract class MorePageEvent extends Equatable {
  const MorePageEvent();

  @override
  List<Object> get props => const [];
}

class LoadMore extends MorePageEvent {}
