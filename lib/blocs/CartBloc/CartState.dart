import 'package:equatable/equatable.dart';
import 'package:faiikan/models/order_item.dart';


abstract class CartState extends Equatable {
  final List<OrderItem> data;
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
    required List<OrderItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}

class CartLoaded2State extends CartState {
  CartLoaded2State({
    required List<OrderItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}

class CartLoadingState extends CartState {
  CartLoadingState({
    required List<OrderItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}

class Initial extends CartState {
  Initial({
    required List<OrderItem> data,
    required int totalPrice,
    required double discount,
  }) : super(data: data, totalPrice: totalPrice, discount: discount);
}
