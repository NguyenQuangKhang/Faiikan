import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:bloc/bloc.dart';
import 'package:faiikan/models/my_rating.dart';
import 'package:faiikan/models/order.dart';
import 'package:faiikan/models/order_item_rating.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'orderitem_rating_event.dart';
import 'orderitem_rating_state.dart';

Map<String, int> mapStatus = {
  "Chờ xác nhận": 1,
  "Đang xử lý": 2,
  "Đang giao": 3,
  "Đã giao": 4,
  "Đã Hủy": 5,
};

class OrderItemRatingBloc extends Bloc<OrderItemRatingEvent, OrderItemRatingState> {
  late OrderItemRating OrderItemRatings;


  OrderItemRatingBloc(OrderItemRatingState initialState) : super(initialState);

  @override
  OrderItemRatingState get initialState => LoadOrderItemRating();

  @override
  Stream<OrderItemRatingState> mapEventToState(
    OrderItemRatingEvent event,
  ) async* {
    if (event is InitiateOrderItemRatingEvent) {

      yield LoadOrderItemRating();

      final response = await http.get(
        Uri.parse(
          "http://$server:8080/api/v1/user/${event.person_id}/get-rating-of_oder?product_id=${event.productId}&product_option=${event.productOptionId}",
        ),
      );
      print(response.body);
      OrderItemRatings = OrderItemRating.fromJson(json.decode(response.body));
      yield LoadedOrderItemRating();
    }

    if (event is UpdateOrderItemRatingEvent) {
      yield LoadOrderItemRating();
      List<http.MultipartFile> listImage = [];

        listImage = await Future.wait(event.listFiles!
            .map((e) async => http.MultipartFile.fromBytes(
          "listFiles",
          e.file.readAsBytesSync(), filename: '${DateTime.now().second}.jpg',contentType:MediaType("image", "jpg")
        ))
            .toList());
     print (listImage[0].contentType);

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            "http://$server:8080/api/v1/rating/${event.ratingId}/update-review",
          ));



      request.fields['comment'] = event.comment;
      request.fields['star'] = event.star.toString();
      request.fields['incognito'] = event.incognito.toString();
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.addAll(listImage);
      var res = await request.send();

      yield UpdateOrderItemRatingState();
    }
  }
}
