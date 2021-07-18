import 'dart:convert';
import 'dart:io';

import 'package:faiikan/models/product.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'ProductDetailEvent.dart';
import 'ProductDetailState.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  late ProductDetailed productDetail;
  late String optionProductId;
  List<Product> listProductAlsoLike = [];
  List<Product> listSimilarProduct = [];
  List<String> options = [];
  late int amount;
  int currentPage = 1;
  int currentSimilar = 1;

  ProductDetailBloc(ProductDetailState initialState) : super(initialState);

  @override
  Stream<ProductDetailState> mapEventToState(event) async* {
    if (event is ProductDetailLoadEvent) {
      print(
        Uri.http("$server:8080", "/api/v1/product/${event.id.toString()}", {
          "user": event.person_id,
        }),
      );
      final response = await http.get(
          Uri.http("$server:8080", "/api/v1/product/${event.id.toString()}", {
            "user": event.person_id,
          }),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          });

      productDetail = ProductDetailed.fromJson(json.decode(response.body));
      this.add(LoadRecommendAndAlsoLikeProductEvent(
          person_id: event.person_id, productId: event.id.toString()));

      yield LoadSuccessProductDetail();
      print(productDetail.flashSaleProduct!.id!);
      yield ProductDetailShowState(data: productDetail);
    }
    if (event is ProductDetailResetEvent) {
      yield LoadingProductDetailReset();
      currentSimilar = 1;
      currentPage = 1;

      final response = await http.get(
          Uri.http("$server:8080", "/api/v1/product/${event.id.toString()}", {
            "user": event.person_id,
          }),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          });

      productDetail = ProductDetailed.fromJson(json.decode(response.body));
      this.add(LoadRecommendAndAlsoLikeProductEvent(
          person_id: event.person_id, productId: event.id.toString()));
      yield ProductDetailShowState(data: productDetail);
    }
    if (event is AddtocartEvent) {
      yield LoadingAddtoCart();

      await http.post(
        Uri.http("$server:8080",
            "/api/v1/cart/${event.person_id}/${event.product_id}/add", {
          'p_option': event.option_amount_id,
          'qty': event.amount.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      );
      yield AddtoCartSuccess();
      yield ProductDetailShowState(data: productDetail);
    }

    if (event is FavoriteTapEvent) {
      http
          .post(Uri.parse(
              "http://$server:8080/api/v1/${event.person_id}/${event.product_id}/update-favorite"))
          .then((value) async {
        this.add(ChangeToFavoriteTapSuccessEvent());
      });
      yield ProductDetailShowState(data: productDetail);
    }
    if (event is LoadMoreProductAlsoLikeEvent) {
      yield LoadingProductAlsoLikeState();
      final response1 = await http.get(
          Uri.parse(
            "http://$server:8080/api/v1/user/${event.person_id}/products-also-like?p=${currentPage.toString()}",
          ),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
      listProductAlsoLike.addAll(json
          .decode(response1.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList());

      currentPage++;

      yield ProductDetailShowState(data: productDetail);
    }
    if (event is LoadRecommendAndAlsoLikeProductEvent) {
      yield LoadingRecommendAndAlsoLikeProduct();
      print(Uri.parse(
        "http://$server:8080/api/v1/user/${event.person_id}/products-also-like?p=${currentPage.toString()}",
      ));
      final response1 = await http.get(
          Uri.parse(
            "http://$server:8080/api/v1/user/${event.person_id}/products-also-like?p=${currentPage.toString()}",
          ),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
      listProductAlsoLike = json
          .decode(response1.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();

      currentPage++;
      final response2 = await http.get(
          Uri.parse(
            "http://$server:8080/api/v1/product/${productDetail.id.toString()}/products-similarity?p=${currentPage.toString()}",
          ),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
      listSimilarProduct = json
          .decode(response2.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      currentSimilar++;
      yield ProductDetailShowState(data: productDetail);
    }
    if (event is ChangeToFavoriteTapSuccessEvent) {
      print("Asdasdasda");
      yield FavoriteTapSuccess();
    }
  }
}
