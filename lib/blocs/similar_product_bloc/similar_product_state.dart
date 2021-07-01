import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SimilarProductState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadingSimilarProduct extends SimilarProductState {}
class LoadMoreSimilarProduct extends SimilarProductState {}


class InitialSimilarProductState extends SimilarProductState {}

class LoadedSimilarProductState extends SimilarProductState {}

