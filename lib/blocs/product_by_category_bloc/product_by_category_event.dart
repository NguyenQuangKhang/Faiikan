
import 'package:equatable/equatable.dart';

abstract class ProductByCategoryEvent extends Equatable {

}

class InitiateProductByCategoryEvent extends ProductByCategoryEvent {
  final String categoryId;
  final String filter;
   InitiateProductByCategoryEvent({required this.categoryId,required this.filter});

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

class LoadMoreProductByCategoryEvent extends ProductByCategoryEvent {
  final String filter;
  final int catId;
  LoadMoreProductByCategoryEvent({required this.filter,required this.catId});

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

class ResetProductByCategoryEvent extends ProductByCategoryEvent {


  ResetProductByCategoryEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}