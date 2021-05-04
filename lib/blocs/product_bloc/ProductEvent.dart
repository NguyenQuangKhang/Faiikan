


import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductLoadEvent extends ProductEvent {


final int SortBy;

  ProductLoadEvent({required this.SortBy});

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class ProductGetMoreDataEvent extends ProductEvent {

  final int SortBy;

  ProductGetMoreDataEvent({required this.SortBy});


  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class ProductByCategoryCodeEvent extends ProductEvent {

final String categoryPath;
const ProductByCategoryCodeEvent({required this.categoryPath});


  @override
  List<Object> get props => [categoryPath];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
//class ProductGetMoreDataByCategoryCodeEvent extends ProductEvent {
//
//  final int SortBy;
//  final Filter filter;
//  final int level_code;
//  const ProductGetMoreDataByCategoryCodeEvent({this.SortBy,this.filter,this.level_code});
//  @override
//  List<Object> get props => [SortBy,Filter];
//
//  @override
//  String toString() =>
//      'ProductButtonPressed { ... }';
//}
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