import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/my_rating.dart';
import 'package:faiikan/models/order.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'my_rating_event.dart';
import 'my_rating_state.dart';

Map<String, int> mapStatus = {
  "Chờ xác nhận": 1,
  "Đang xử lý": 2,
  "Đang giao": 3,
  "Đã giao": 4,
  "Đã Hủy": 5,
};

class MyRatingBloc extends Bloc<MyRatingEvent, MyRatingState> {
  List<MyRating> MyRatings = [];
  int page = 1;
  late TotalCount count;

  MyRatingBloc(MyRatingState initialState) : super(initialState);

  @override
  MyRatingState get initialState => LoadMyRating();

  @override
  Stream<MyRatingState> mapEventToState(
    MyRatingEvent event,
  ) async* {
    if (event is InitiateMyRatingEvent) {
      page=1;
      yield InitialMyRatingState();
      final response1 = await http.get(
        Uri.parse(
          "http://$server:8080/api/v1/user/${event.person_id}/count-star-rating",
        ),
      );
      count = TotalCount.fromJson(json.decode(response1.body));
      yield LoadMyRating();
   print(Uri.parse(
     "http://$server:8080/api/v1/user/${event.person_id}/get-rating?star=${event.star}&p=$page&p_size=10",
   ),);
      final response = await http.get(
        Uri.parse(
          "http://$server:8080/api/v1/user/${event.person_id}/get-rating?star=${event.star}&p=$page&p_size=10",
        ),
      );
      print(response.body);
      MyRatings = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<MyRating>((json) => MyRating.fromJson(json))
          .toList();
      page++;
      yield LoadedMyRating();
    }
    if(event is ChangeStar)
      {
        yield LoadMyRating();
        print(Uri.parse(
          "http://$server:8080/api/v1/user/${event.person_id}/get-rating?star=${event.star}&p=$page&p_size=10",
        ),);
        final response = await http.get(
          Uri.parse(
            "http://$server:8080/api/v1/user/${event.person_id}/get-rating?star=${event.star}&p=$page&p_size=10",
          ),
        );
        print(response.body);
        MyRatings = json
            .decode(response.body)
            .cast<Map<String, dynamic>>()
            .map<MyRating>((json) => MyRating.fromJson(json))
            .toList();
        page++;
        yield LoadedMyRating();
      }
    if (event is LoadMoreMyRatingEvent) {
      yield LoadMyRating();
      print(Uri.parse(
        "http://$server:8080/api/v1/user/${event.person_id}/get-rating?star=${event.star}&p=$page&p_size=10",
      ));
      final response = await http.get(
        Uri.parse(
          "http://$server:8080/api/v1/user/${event.person_id}/get-rating?star=${event.star}&p=$page&p_size=10",
        ),
      );
      MyRatings.addAll(json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<MyRating>((json) => MyRating.fromJson(json))
          .toList());
      page++;
      yield LoadedMyRating();
    }
    if (event is UpdateSttMyRatingEvent) {
      yield LoadMyRating();
//      await http.put(
//        Uri.http("$server:8080", "/api/v1/order/${event.orderId}/update-status",
//            {'stt': event.status}),
//        headers: <String, String>{
//          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
//        },
//      );

      yield UpdateMyRatingState();
    }
  }
}
