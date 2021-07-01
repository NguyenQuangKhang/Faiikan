import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadSearch extends SearchState {}
class LoadMoreSearch extends SearchState {}


class InitialSearchState extends SearchState {}

class ShowResultState extends SearchState {}
class ShowHotSearchState extends SearchState {}
class RecommendSearchState extends SearchState {}
class RecommendSearchState2 extends SearchState {}
