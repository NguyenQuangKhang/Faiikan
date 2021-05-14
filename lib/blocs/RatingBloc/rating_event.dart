
import 'package:equatable/equatable.dart';

abstract class RatingEvent extends Equatable {

}

class InitiateRatingEvent extends RatingEvent {
  final String product_id;

  InitiateRatingEvent({required this.product_id});
  @override
  List<Object> get props => [product_id];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}
class UpdateRatingEvent extends RatingEvent {
  final String product_id;
  final String select;


  UpdateRatingEvent({required this.product_id,required this.select});
  @override
  List<Object> get props => [product_id,select];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}
class LoadMoreRatingEvent extends RatingEvent {
  final String product_id;
  final String select;


  LoadMoreRatingEvent({required this.product_id,required this.select});
  @override
  List<Object> get props => [product_id,select];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}