import 'package:equatable/equatable.dart';

abstract class MyOrderEvent extends Equatable {}

class InitiateMyOrderEvent extends MyOrderEvent {
  final String person_id;
  final String status;

  InitiateMyOrderEvent({required this.person_id, required this.status});

  @override
  List<Object> get props => [person_id];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class UpdateSttMyOrderEvent extends MyOrderEvent {
  final int index;
  final String orderId;
  final String status;

  UpdateSttMyOrderEvent({
    required this.orderId,
    required this.status,
    required this.index,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}
