import 'package:equatable/equatable.dart';


abstract class CartEvent extends Equatable {
  const CartEvent();
}
class GetCartEvent extends CartEvent {

  final String person_id;

  GetCartEvent({ required this.person_id});
  @override
  List<Object> get props => [person_id];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class UpdateCartEvent extends CartEvent {
  final int id;
  final int amount;

  final int index;
  final int optionId;

  UpdateCartEvent({ required this.id,required this.amount,required this.index,required this.optionId});
  @override
  List<Object> get props => [id,amount,index,optionId];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class DeleteCartEvent extends CartEvent {
  final String id;
  final int index;
  DeleteCartEvent({ required this.id,required this.index});
  @override
  List<Object> get props => [id,index];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class CheckItemCartEvent extends CartEvent {
  final int index;
  final bool value;
  CheckItemCartEvent({required this.index,required this.value});
  @override
  List<Object> get props => [index,value];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
class CheckAllItemCartEvent extends CartEvent {
  final bool value;
  CheckAllItemCartEvent({required this.value});
  @override
  List<Object> get props => [value];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
