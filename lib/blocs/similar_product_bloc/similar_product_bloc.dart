import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';

import 'package:http/http.dart' as http;

import 'similar_product_event.dart';
import 'similar_product_state.dart';

class SimilarProductBloc extends Bloc<SimilarProductEvent, SimilarProductState> {
  late List<Product> data;
  int page = 1;

  SimilarProductBloc(SimilarProductState initialState) : super(initialState);


  SimilarProductState get initialState => InitialSimilarProductState();

  @override
  Stream<SimilarProductState> mapEventToState(
      SimilarProductEvent event,
  ) async* {
    if (event is InitiateSimilarProductEvent) {
      yield LoadingSimilarProduct();
      final response = await http.get(
          Uri.parse("http://$server:8080/api/v1/product/${event.productId}/products-similarity?p=$page"));


      data = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      yield LoadedSimilarProductState();
    }

    if (event is LoadMoreSimilarProductEvent) {
      yield LoadMoreSimilarProduct();

      final response = await http.get(
          Uri.parse("http://$server:8080/api/v1/product/${event.productId}/products-similarity?p=$page"));
      data.addAll(json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList());
      page++;
      yield LoadedSimilarProductState();
    }
//    if(event is ResetSimilarProductEvent)
//      {
//        yield ShowHotSearchState();
//      }
  }
}
