import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProductByCategoryState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadingProductByCategory extends ProductByCategoryState {}
class LoadMoreProductByCategory extends ProductByCategoryState {}


class InitialProductByCategoryState extends ProductByCategoryState {}

class LoadedProductByCategoryState extends ProductByCategoryState {}

