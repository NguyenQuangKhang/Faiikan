import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MyOrderState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadMyOrder extends MyOrderState {}


class InitialMyOrderState extends MyOrderState {}

class UpdateMyOrderState extends MyOrderState {}



