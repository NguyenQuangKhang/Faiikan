
import 'package:equatable/equatable.dart';

abstract class SimilarProductEvent extends Equatable {

}

class InitiateSimilarProductEvent extends SimilarProductEvent {
final String productId;

  InitiateSimilarProductEvent({required this.productId});
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

class LoadMoreSimilarProductEvent extends SimilarProductEvent {
  final String productId;


  LoadMoreSimilarProductEvent({required this.productId,});
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

class ResetSimilarProductEvent extends SimilarProductEvent {


  ResetSimilarProductEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}