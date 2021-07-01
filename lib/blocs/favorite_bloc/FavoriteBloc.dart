import 'dart:convert';

import 'package:faiikan/models/product.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'FavoriteEvent.dart';
import 'FavortieState.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<Product> listdata = [];
  List<Product> listRecommendTopRating = [];
  late int index;

  FavoriteBloc(FavoriteState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  FavoriteState get initialState => InitialFavorite(data: []);

  @override
  Stream<FavoriteState> mapEventToState(event) async* {
    if (event is FavoriteLoadEvent) {
      yield FavoriteLoading(data: listdata);
      final response1 = await http.get(
          Uri.parse( "http://$server:8080/api/v1/user/${event.person_id}/products-also-like"));
      listRecommendTopRating = json
          .decode(response1.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/${event.person_id}/get-favorite-products"));
      listdata = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      if (state is FavoriteLoadedState)
        yield FavoriteLoaded2State(data: listdata);
      else
        yield FavoriteLoadedState(data: listdata);

    }
    if (event is FavoriteTap) {
      listdata[event.index].isLiked = !listdata[event.index].isLiked;
      http.post(Uri.parse(
          "http://$server:8080/api/v1/${event.person_id}/${event.product_id}/update-favorite"));

      if (state is FavoriteLoadedState)
        yield FavoriteLoaded2State(data: listdata);
      else
        yield FavoriteLoadedState(data: listdata);
    }
  }
}
