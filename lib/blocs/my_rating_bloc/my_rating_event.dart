import 'package:equatable/equatable.dart';

abstract class MyRatingEvent extends Equatable {}

class InitiateMyRatingEvent extends MyRatingEvent {
  final String person_id;
  final int star;

  InitiateMyRatingEvent({required this.person_id, required this.star,});

  @override
  List<Object> get props => [person_id];

  @override
  String toString() => 'LoginButtonPressed {  }';
}
class ChangeStar extends MyRatingEvent {
  final String person_id;
  final int star;

  ChangeStar({required this.person_id, required this.star,});

  @override
  List<Object> get props => [person_id];

  @override
  String toString() => 'LoginButtonPressed {  }';
}
class LoadMoreMyRatingEvent extends MyRatingEvent {
  final String person_id;
  final int star;

  LoadMoreMyRatingEvent({required this.person_id, required this.star,});

  @override
  List<Object> get props => [person_id];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class UpdateSttMyRatingEvent extends MyRatingEvent {
  final int index;
  final String orderId;
  final String status;

  UpdateSttMyRatingEvent({
    required this.orderId,
    required this.status,
    required this.index,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}
