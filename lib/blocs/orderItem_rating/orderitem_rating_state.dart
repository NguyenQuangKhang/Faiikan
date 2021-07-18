import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class OrderItemRatingState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadOrderItemRating extends OrderItemRatingState {}
class LoadedOrderItemRating extends OrderItemRatingState {}


class InitialOrderItemRatingState extends OrderItemRatingState {}

class UpdateOrderItemRatingState extends OrderItemRatingState {}



