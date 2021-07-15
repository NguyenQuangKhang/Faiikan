import 'package:equatable/equatable.dart';
import 'package:faiikan/models/input_order_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCartEvent extends CartEvent {
  final String person_id;

  GetCartEvent({required this.person_id});

  @override
  List<Object> get props => [person_id];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UpdateCartEvent extends CartEvent {
  final int id;
  final int userId;
  final int amount;

  final int index;
  final int optionId;

  UpdateCartEvent(
      {required this.userId,
      required this.id,
      required this.amount,
      required this.index,
      required this.optionId});

  @override
  List<Object> get props => [id, amount, index, optionId];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class DeleteCartEvent extends CartEvent {
  final String id;
  final int index;

  DeleteCartEvent({required this.id, required this.index});

  @override
  List<Object> get props => [id, index];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
class DeleteListCartItemEvent extends CartEvent {
  final List<String> id;

  DeleteListCartItemEvent({required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class CheckItemCartEvent extends CartEvent {
  final int index;
  final bool value;

  CheckItemCartEvent({required this.index, required this.value});

  @override
  List<Object> get props => [index, value];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class CheckAllItemCartEvent extends CartEvent {
  final bool value;

  CheckAllItemCartEvent({required this.value});

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetProductOptionEvent extends CartEvent {
  final String productId;

  GetProductOptionEvent({required this.productId});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UpdateCartBySheetEvent extends CartEvent {
  final int id;
  final int userId;
  final int amount;

  final int index;
  final int optionId;

  UpdateCartBySheetEvent(
      {required this.userId,
      required this.id,
      required this.amount,
      required this.index,
      required this.optionId});

  @override
  List<Object> get props => [id, amount, index, optionId];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class CreateOrderEvent extends CartEvent {
  final String userId;
  final String addressId;
  final double subTotal;
  final double shippingFee;
  final double grandTotal;
  final double discount;
  final String content;
  final int shipping;
  final int paymentMethod;
  final int status;
  final List<InputOrderItem> listItem;

  CreateOrderEvent({
    required this.userId,
    required this.addressId,
    required this.content,
    required this.discount,
    required this.grandTotal,
    required this.listItem,
    required this.paymentMethod,
    required this.shipping,
    required this.shippingFee,
    required this.status,
    required this.subTotal,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
