


import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductLoadEvent extends ProductEvent {

final int userId;
final int SortBy;

  ProductLoadEvent({required this.SortBy,required this.userId});

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class ProductGetMoreDataEvent extends ProductEvent {
  final String userId;
  final int SortBy;

  ProductGetMoreDataEvent({required this.SortBy,required this.userId});


  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class ProductByCategoryCodeEvent extends ProductEvent {

final String categoryId;
final String filter;
const ProductByCategoryCodeEvent({required this.categoryId,required this.filter});


  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
class ProductGetMoreDataByCategoryCodeEvent extends ProductEvent {

  final String filter;
  final int catId;
  const ProductGetMoreDataByCategoryCodeEvent({required this.filter,required this.catId});
  @override
  List<Object> get props => [catId,filter];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
//
//
//class FilterandSortByEvent extends ProductEvent {
//
//  final int SortBy;
//final Filter filter;
//final int level_code;
//const FilterandSortByEvent({this.SortBy,this.filter,this.level_code});
//
//
//@override
//List<Object> get props => [SortBy,Filter];
//
//@override
//String toString() =>
//    'ProductButtonPressed { ... }';
//}

class RecommendTopRatingEvent extends ProductEvent {

  final String userId;
  const RecommendTopRatingEvent({required this.userId});


  @override
  List<Object> get props => [userId];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class SeenProductEvent extends ProductEvent {

  final String userId;
  const SeenProductEvent({required this.userId});


  @override
  List<Object> get props => [userId];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}