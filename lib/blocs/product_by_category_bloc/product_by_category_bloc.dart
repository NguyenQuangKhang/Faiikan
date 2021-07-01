import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';

import 'package:http/http.dart' as http;

import 'product_by_category_event.dart';
import 'product_by_category_state.dart';

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {

  List<Product> listdataByCategory = [];
  int currentPageByCateGory = 1;

  ProductByCategoryBloc(ProductByCategoryState initialState) : super(initialState);

  ProductByCategoryState get initialState => InitialProductByCategoryState();

  @override
  Stream<ProductByCategoryState> mapEventToState(
    ProductByCategoryEvent event,
  ) async* {
    if (event is InitiateProductByCategoryEvent) {
      yield LoadingProductByCategory();
      final response = await http.get(Uri.parse(
          "http://${server}:8080api/v1/cat/${event.categoryId}/products?filter=${event.filter}&p=${currentPageByCateGory.toString()}"));
      listdataByCategory = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      currentPageByCateGory++;
      yield LoadedProductByCategoryState();
    }

    if (event is LoadMoreProductByCategoryEvent) {
      yield LoadMoreProductByCategory();

      final response = await http.get(Uri.parse(
          "http://${server}:8080api/v1/cat/${event.catId}/products?filter=${event.filter}&p=${currentPageByCateGory.toString()}"));
      listdataByCategory.addAll(json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList());
      currentPageByCateGory++;

      yield LoadedProductByCategoryState();
    }
//    if(event is ResetProductByCategoryEvent)
//      {
//        yield ShowHotSearchState();
//      }
  }
}
