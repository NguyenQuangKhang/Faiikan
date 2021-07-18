import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/flash_sale_period.dart';
import 'package:faiikan/models/flash_sale_product.dart';


import 'package:faiikan/utils/server_name.dart';

import 'package:http/http.dart' as http;

import 'flash_sale_event.dart';
import 'flash_sale_state.dart';

class FlashSaleBloc extends Bloc<FlashSaleEvent, FlashSaleState> {
   List<FlashSaleProduct> data=[];
   List<FlashSaleProduct> dataOfPeriod=[];
  int page = 1;
  List<FlashSalePeriod> period=[];
  int idPeriod =5;
  FlashSaleBloc(FlashSaleState initialState) : super(initialState);


  FlashSaleState get initialState => InitialFlashSaleState();

  @override
  Stream<FlashSaleState> mapEventToState(
      FlashSaleEvent event,
  ) async* {
    if (event is InitiateFlashSaleEvent) {
      yield LoadingFlashSale();

      print(Uri.parse("http://$server:8080/api/v1/flashsale/get-for-mobile"));
      final response = await http.get(
          Uri.parse("http://$server:8080/api/v1/flashsale/get-for-mobile"));
            period = json
                .decode(response.body)
                .cast<Map<String, dynamic>>()
                .map<FlashSalePeriod>((json) => FlashSalePeriod.fromJson(json))
                .toList();

       for(int i=0;i<period.length;i++)
         {
           if(period[i].status=="Đang diễn ra")
             idPeriod=period[i].id!;
         }
      yield SucessfulGetPeriodState();

print(Uri.parse("http://$server:8080/api/v1/flashsale/${idPeriod}/products-mobile?p=1&p_size=10"));
      final response1 = await http.get(
          Uri.parse("http://$server:8080/api/v1/flashsale/${period.firstWhere((element) => element.status=="Đang diễn ra").id}/products-mobile?p=1&p_size=10"));
      print(response1.body);
      data = json
          .decode(response1.body)
          .cast<Map<String, dynamic>>()
          .map<FlashSaleProduct>((json) => FlashSaleProduct.fromJson(json))
          .toList();
      print(data.length);
      yield LoadedFlashSaleState();
    }

    if (event is LoadProductOfPeriod) {
      yield LoadingFlashSale();
       page=1;
      final response = await http.get(
          Uri.parse("http://$server:8080/api/v1/flashsale/${event.id==-1?idPeriod:event.id}/products-mobile?p=$page&p_size=10"));
      dataOfPeriod = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<FlashSaleProduct>((json) => FlashSaleProduct.fromJson(json))
          .toList();
      page++;
      yield SucessfulGetPeriodState();
      yield LoadedFlashSaleState();
    }
    if (event is LoadMoreProductOfPeriod) {
      yield LoadMoreFlashSale();

      final response = await http.get(
          Uri.parse("http://$server:8080/api/v1/product/${event.id==-1?idPeriod:event.id}/products-similarity?p=$page"));
      dataOfPeriod.addAll(json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<FlashSaleProduct>((json) => FlashSaleProduct.fromJson(json))
          .toList());
      page++;
      yield LoadedFlashSaleState();
    }
//    if(event is ResetFlashSaleEvent)
//      {
//        yield ShowHotSearchState();
//      }
  }
}
