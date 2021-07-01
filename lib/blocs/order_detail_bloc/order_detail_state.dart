import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class OrderDetailState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadingOrderDetail extends OrderDetailState {}
class LoadMoreOrderDetail extends OrderDetailState {}


class InitialOrderDetailState extends OrderDetailState {}

class LoadedOrderDetailState extends OrderDetailState {}

class CreateReviewSuccessState extends OrderDetailState {}
