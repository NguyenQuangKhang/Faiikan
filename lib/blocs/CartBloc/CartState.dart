import 'package:equatable/equatable.dart';
import 'package:faiikan/models/cart_item.dart';
import 'package:faiikan/models/order_item.dart';


abstract class CartState extends Equatable {
  final List<CartItem> data;
  final int totalPrice;
  final double discount;

  CartState(
      {required this.data, required this.totalPrice, required this.discount});

  @override
  List<Object> get props => [data];

  @override
  bool get stringify => true;
}

class CartLoadedState extends CartState {
  CartLoadedState({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}

class CartLoaded2State extends CartState {
  CartLoaded2State({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}
class CreateOrderSuccessfulState extends CartState {
  CreateOrderSuccessfulState({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}
class DeleteListItemSuccessfulState extends CartState {
  DeleteListItemSuccessfulState({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}

class CartLoadingState extends CartState {
  CartLoadingState({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}

class InitialCart extends CartState {
  InitialCart({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}

class ErrorCart extends CartState {
  final String error;
  ErrorCart({required this.error}) : super(data:[], totalPrice: 0,discount: 0.0);
}
class LoadingGetProductOptionState extends CartState {
  LoadingGetProductOptionState({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}
class LoadedGetProductOptionState extends CartState {
  LoadedGetProductOptionState({
    required List<CartItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}