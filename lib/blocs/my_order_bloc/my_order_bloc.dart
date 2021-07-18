import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/order.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'my_order_event.dart';
import 'my_order_state.dart';

Map<String,int> mapStatus = {
  "Chờ xác nhận": 1,
  "Đang xử lý" : 2,
  "Đang giao" : 3,
  "Đã giao" : 4,
  "Đã hủy": 5,
};

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  List<Order> myOrders=[];

  MyOrderBloc(MyOrderState initialState) : super(initialState);

  @override
  MyOrderState get initialState => InitialMyOrderState();

  @override
  Stream<MyOrderState> mapEventToState(
    MyOrderEvent event,
  ) async* {
    if (event is InitiateMyOrderEvent) {
      yield LoadMyOrder();
      print(Uri.parse(
        "http://$server:8080/api/v1/user/${event.person_id}/get-list-order?stt=${mapStatus[event.status]}",
      ));
      final response = await http.get(
          Uri.parse(
            "http://$server:8080/api/v1/user/${event.person_id}/get-list-order?stt=${mapStatus[event.status]}",
          ),
        );
      myOrders = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Order>((json) => Order.fromJson(json))
          .toList();

      yield InitialMyOrderState();
    }
    if(event is UpdateSttMyOrderEvent)
      {
        yield LoadMyOrder();
       await http.put(
          Uri.http("$server:8080",
              "/api/v1/order/${event.orderId}/update-status", {
                'stt' : event.status
              }),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          },
        );
        myOrders.removeAt(event.index);
        yield UpdateMyOrderState();
      }
  }
}
