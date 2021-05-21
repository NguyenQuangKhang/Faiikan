import 'package:equatable/equatable.dart';
import 'package:faiikan/models/product_detail.dart';

abstract class ProductDetailState extends Equatable {}

class ProductDetailShowState extends ProductDetailState {
  ProductDetailShowState({
    required ProductDetailed data,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialProductDetail extends ProductDetailState {
  InitialProductDetail();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadingProductDetail extends ProductDetailState {
  LoadingProductDetail();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadingProductDetailReset extends ProductDetailState {
  LoadingProductDetailReset();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ErrorProductDetail extends ProductDetailState {
  final String error;
  ErrorProductDetail({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}