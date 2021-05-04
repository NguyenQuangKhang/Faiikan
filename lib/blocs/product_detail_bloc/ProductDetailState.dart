import 'package:equatable/equatable.dart';
import 'package:faiikan/models/product_detail.dart';

abstract class ProductDetailState extends Equatable {}

class ProductDetailShowState extends ProductDetailState {
  ProductDetailShowState({
    required ProductDetailed data,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitialProductDetail extends ProductDetailState {
  InitialProductDetail();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
