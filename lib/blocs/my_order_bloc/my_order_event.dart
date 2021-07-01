
import 'package:equatable/equatable.dart';

abstract class MyOrderEvent extends Equatable {

}

class InitiateMyOrderEvent extends MyOrderEvent {
  final String person_id;
  final String status;
  InitiateMyOrderEvent({required this.person_id,required this.status});
  @override
  List<Object> get props => [person_id];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

