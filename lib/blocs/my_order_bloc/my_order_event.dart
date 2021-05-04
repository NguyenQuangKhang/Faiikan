
import 'package:equatable/equatable.dart';

abstract class MyOrderEvent extends Equatable {

}

class InitiateMyOrderEvent extends MyOrderEvent {
  final String person_id;

  InitiateMyOrderEvent({required this.person_id});
  @override
  List<Object> get props => [person_id];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

