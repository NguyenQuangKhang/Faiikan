import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/order_detail.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'order_detail_event.dart';
import 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  late OrderDetail orderDetail;

  OrderDetailBloc(OrderDetailState initialState) : super(initialState);

  OrderDetailState get initialState => InitialOrderDetailState();

  @override
  Stream<OrderDetailState> mapEventToState(
    OrderDetailEvent event,
  ) async* {
    if (event is InitiateOrderDetailEvent) {
      yield LoadingOrderDetail();
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/order/${event.orderId}/detail-order"));
      orderDetail = OrderDetail.fromJson(json.decode(response.body));

      yield LoadedOrderDetailState();
    }

    if (event is CreateReviewEvent) {
      yield LoadingOrderDetail();
      List<http.MultipartFile> listImage = [];
      if (event.listImage != null) {
        final List<File> images =
            await Future.wait(event.listImage!.map((e) async => (await e.file)!));
        listImage = await Future.wait(images
            .map((e) async => http.MultipartFile.fromBytes(
                  "listItem",
                  e.readAsBytesSync(), filename: '${DateTime.now().second}.jpg',contentType:MediaType("image", "jpg")
                ))
            .toList());
      }

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            "http://$server:8080/api/v1/user/${event.userId}/review-product",
          ));


      request.fields['orderItem'] = event.orderItem;
      request.fields['comment'] = event.comment;
      request.fields['star'] = event.star.toString();
      request.fields['incognito'] = event.incognito.toString();
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.addAll(listImage);
      print(request.fields);
      var res = await request.send();
      print(res.statusCode);

//      var formData = FormData.fromMap({
//        "orderItem": event.orderItem,
//        "comment": event.comment,
//        "star": event.star.toString(),
//        "incognito": event.incognito.toString(),
//        'files':  listImage
//      });
//        Dio dio =new Dio();
//        dio.options.contentType = 'multipart/form-data; boundary=<calculated when request is sent>';
//      var response = await dio.post(
//          "http://$server:8080/api/v1/user/${event.userId}/review-product",
//          data: formData);
//      print(response.statusCode);
      yield CreateReviewSuccessState();
      yield LoadedOrderDetailState();
    }
//    if(event is ResetOrderDetailEvent)
//      {
//        yield ShowHotSearchState();
//      }
  }
}
