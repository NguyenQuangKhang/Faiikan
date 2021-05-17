import 'dart:convert';

import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'ProductDetailEvent.dart';
import 'ProductDetailState.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  late ProductDetailed productDetail;
  late String optionProductId;
  late int amount;
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
      yield LoadingProductDetail();
//      try {

        await http.post(
          Uri.parse(
              "http://$server:8080/api/v1/cart/142519/${event.product_id}/add"),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          },
          body: <String, String>{
            'p_option': event.option_amount_id,
            'amount': event.amount.toString(),
          },
        );

        yield ProductDetailShowState(data: productDetail);
//      } catch (e) {}
    }

    if (event is FavoriteTapEvent) {}
  }
}
