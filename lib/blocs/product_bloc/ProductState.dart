import 'package:equatable/equatable.dart';
import 'package:faiikan/models/product.dart';

//import 'package:fashionshop/src/model/Filter.dart';
//import 'package:fashionshop/src/new_model/product.dart';

abstract class ProductsState extends Equatable {
  final List<Product> data;
  final int sortBy;

//  final Filter filterRules;
  final String error;

  ProductsState({
    required this.data,
//    this.filterRules,
    required this.sortBy,
    required this.error,
  });

  bool get isProductsLoading => data == null;

//  bool get isFilterRulesVisible => filterRules != null;
  bool get hasError => error != null;

  @override
  List<Object> get props => [data, /*filterRules,*/ sortBy];

  @override
  bool get stringify => true;
}

class ProductsGridViewState extends ProductsState {
  ProductsGridViewState({
    required List<Product> data,
    required int sortBy,
// required   Filter filterRules,
    required String error,
  }) : super(
            data: data,
            sortBy: sortBy,
            /*filterRules: filterRules,*/ error: error);

  ProductsGridViewState getTiles() {
    return ProductsGridViewState(
      data: data,
      sortBy: sortBy,
      error: '', /*filterRules: filterRules*/
    );
  }
}

class ProductsAddmoreState extends ProductsState {
  ProductsAddmoreState({
    required List<Product> data,
    required int sortBy,
//    Filter filterRules,
    required String error,
  }) : super(
            data: data,
            sortBy: sortBy,
            /*filterRules: filterRules,*/ error: error);

  ProductsAddmoreState getTiles() {
    return ProductsAddmoreState(
      data: data,
      sortBy: sortBy,
      error: '', /*filterRules: filterRules*/
    );
  }

  @override
  Future<ProductsAddmoreState> copyWith({
    required List<Product> data,
    required int sortBy,
// required  Filter filterRules,
    required String error,
  }) async {
    return ProductsAddmoreState(
      data: data ,
//      filterRules: filterRules ?? this.filterRules,
      sortBy: sortBy ,
      error: error,
    );
  }
}

class Loading extends ProductsState {
  Loading({
    required List<Product> data,
    required int sortBy,
//    Filter filterRules,
    required String error,
  }) : super(
            data: data,
            sortBy: sortBy,
            /*filterRules: filterRules,*/ error: error);

  Loading getTiles() {
    return Loading(
      data: data,
      sortBy: sortBy,
      error: '', /*filterRules: filterRules*/
    );
  }
}

class InitialProductState extends ProductsState {
  InitialProductState({
    required List<Product> data,
    required int sortBy,
//    Filter filterRules,
    required String error,
  }) : super(
            data: data,
            sortBy: sortBy,
            /*filterRules: filterRules,*/ error: error);


}
