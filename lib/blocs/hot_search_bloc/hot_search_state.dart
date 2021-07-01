import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class HotSearchState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadHotSearch extends HotSearchState {}
class LoadMoreHotSearch extends HotSearchState {}


class InitialHotSearchState extends HotSearchState {}

class ShowHotSearchState extends HotSearchState {}

