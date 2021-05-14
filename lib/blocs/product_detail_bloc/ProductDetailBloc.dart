import 'dart:convert';

import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'ProductDetailEvent.dart';
import 'ProductDetailState.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  late ProductDetailed productDetail;

  ProductDetailBloc(ProductDetailState initialState) : super(initialState);

  @override
  Stream<ProductDetailState> mapEventToState(event) async* {
    if (event is ProductDetailLoadEvent) {
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/product/${event.id.toString()}"));
      productDetail = ProductDetailed.fromJson(json.decode(response.body));
      yield ProductDetailShowState(data: productDetail);
    }
    if (event is AddtocartEvent) {
      yield ProductDetailShowState(data: productDetail);
    }

    if (event is FavoriteTapEvent) {}
  }
}
