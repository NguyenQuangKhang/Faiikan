import 'dart:convert';

import 'package:faiikan/models/cart_item.dart' ;
import 'package:faiikan/models/input_order_item.dart';
import 'package:faiikan/models/product_detail.dart' as productDetail;
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CartEvent.dart';
import 'CartState.dart';
import 'package:http/http.dart' as http;

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> list_data = [];
  late double totalPrice = 0;
  late double discount;
  late String userId;
  late productDetail.ProductOption productOption;
  late int optionProductId;
  late int amount;
  late int index;
   List<String> options =[];
   late productDetail.Price price;


  CartBloc(CartState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  CartState get initialState =>
      InitialCart(data: [], discount: 0, totalPrice: 0);

  @override
  Stream<CartState> mapEventToState(event) async* {
    if (event is GetCartEvent) {
      userId = event.person_id;
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/cart/${event.person_id}/get-list-item"));
      list_data = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<CartItem>((json) => CartItem.fromJson(json))
          .toList();
      yield CartLoadedState(
          data: list_data,
          discount: state.discount,
          totalPrice: (totalPrice - totalPrice * state.discount).toInt());
    }
    if (event is UpdateCartEvent) {
      try {
        http.put(
          Uri.http("$server:8080",
              "/api/v1/cart/${event.userId}/${event.id}/update", {
            'p_option': event.optionId.toString(),
            'qty': event.amount.toString(),
          }),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          },
        );
        if (list_data[event.index].isChosen == true)
          totalPrice += (event.amount - list_data[event.index].amount) *
              list_data[event.index].optionProduct.price.value;
        list_data[event.index].amount = event.amount;
        if (state is CartLoadedState)
          yield CartLoaded2State(
              data: list_data,
              discount: state.discount,
              totalPrice: (totalPrice - totalPrice * state.discount).toInt());
        else
          yield CartLoadedState(
              data: list_data,
              discount: state.discount,
              totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      } catch (e) {
        print(e.toString());
        yield ErrorCart(error: e.toString());
        this.add(GetCartEvent(person_id: userId));
      }
    }
    if (event is UpdateCartBySheetEvent) {
      try {
        http.put(
          Uri.http("$server:8080",
              "/api/v1/cart/${event.userId}/${event.id}/update", {
                'p_option': event.optionId.toString(),
                'qty': event.amount.toString(),
              }),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          },
        );
        if (list_data[event.index].isChosen == true)
          totalPrice += (event.amount - list_data[event.index].amount) *
              list_data[event.index].optionProduct.price.value;
        list_data[event.index].amount = event.amount;
        list_data[event.index].optionProduct=OptionProduct(productOptionId: event.optionId, price: Price(id: price.id, value: price.value), quantity:  Quantity(id: 0, value: 0), color: Color(id: 0, value: options.length>1?options[1]:""), size: Size(id: 0, value: options[0]), image: list_data[event.index].optionProduct.image);
         for(int i =0;i<list_data.length;i++)
           {
             if(i!=event.index && event.optionId == list_data[i].optionProduct.productOptionId)
               {
                 if(i>event.index)
                   {
                     list_data[event.index].amount+= list_data[i].amount;
                     list_data.removeAt(i);
                   }
                 else {
                   list_data[i].amount+= list_data[event.index].amount;
                   list_data.removeAt(event.index);
                 }
               }
           }
        if (state is CartLoadedState)
          yield CartLoaded2State(
              data: list_data,
              discount: state.discount,
              totalPrice: (totalPrice - totalPrice * state.discount).toInt());
        else
          yield CartLoadedState(
              data: list_data,
              discount: state.discount,
              totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      } catch (e) {
        print(e.toString());
        yield ErrorCart(error: e.toString());
        this.add(GetCartEvent(person_id: userId));
      }
    }
    if (event is DeleteCartEvent) {
      try {
        http.delete(
          Uri.parse("http://$server:8080/api/v1/cart/${event.id}/remove"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        list_data.removeAt(event.index);
        if (state is CartLoadedState)
          yield CartLoaded2State(
              data: list_data,
              discount: state.discount,
              totalPrice: (totalPrice - totalPrice * state.discount).toInt());
        else
          yield CartLoadedState(
              data: list_data,
              discount: state.discount,
              totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      } catch (e) {
        print(e.toString());
        yield ErrorCart(error: e.toString());
        this.add(GetCartEvent(person_id: userId));
      }
    }
    if (event is DeleteListCartItemEvent) {
      try {
        for(int i =0;i<event.id.length;i++)
        {
          await http.delete(
            Uri.parse("http://$server:8080/api/v1/cart/${event.id[i]}/remove"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
          );
        }
        yield DeleteListItemSuccessfulState(
            data: list_data,
            discount: state.discount,
            totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      } catch (e) {
        print(e.toString());
        yield ErrorCart(error: e.toString());
        this.add(GetCartEvent(person_id: userId));
      }
    }
    if (event is CheckItemCartEvent) {
      list_data[event.index].isChosen = event.value;

      totalPrice = 0;
      for (int i = 0; i < list_data.length; i++) {
        if (list_data[i].isChosen == true) {
          totalPrice +=
              list_data[i].amount * list_data[i].optionProduct.price.value;
        }
      }
      if (state is CartLoadedState)
        yield CartLoaded2State(
            data: list_data,
            discount: state.discount,
            totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      else
        yield CartLoadedState(
            data: list_data,
            discount: state.discount,
            totalPrice: (totalPrice - totalPrice * state.discount).toInt());
    }

    if (event is CheckAllItemCartEvent) {
      for (int i = 0; i < list_data.length; i++) {
        list_data[i].isChosen = event.value;
      }
      totalPrice = 0;
      for (int i = 0; i < list_data.length; i++) {
        if (list_data[i].isChosen == true) {
          totalPrice +=
              list_data[i].amount * list_data[i].optionProduct.price.value;
        }
      }
      if (state is CartLoadedState)
        yield CartLoaded2State(
            data: list_data,
            discount: state.discount,
            totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      else
        yield CartLoadedState(
            data: list_data,
            discount: state.discount,
            totalPrice: (totalPrice - totalPrice * state.discount).toInt());
    }

    if (event is GetProductOptionEvent) {
      yield LoadingGetProductOptionState(
          data: list_data,
          discount: state.discount,
          totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/product/${event.productId}/all-option"));
      productOption = productDetail.ProductOption.fromJson(json
          .decode(response.body));
      yield LoadedGetProductOptionState(
          data: list_data,
          discount: state.discount,
          totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      yield CartLoadedState(
          data: list_data,
          discount: state.discount,
          totalPrice: (totalPrice - totalPrice * state.discount).toInt());
    }
    if(event is CreateOrderEvent)
      {

        yield CartLoadingState( data: list_data,
            discount: state.discount,
            totalPrice: (totalPrice - totalPrice * state.discount).toInt());
        final response = await http.post(
            Uri.http("$server:8080", "/api/v1/order/create-order",
              ),
            body: jsonEncode({
                "user_id": event.userId,
                "address_id": event.addressId,
                "sub_total": event.subTotal,
                "shipping_fee":event.shippingFee,
                "grand_total" :event.grandTotal,
                "discount": event.discount,
                "content": event.content,
                "shipping": event.shipping,
                "payment_method":event.paymentMethod,
                "status": event.status,
                "list_item": event.listItem.map((e) => e.toJson()).toList()

            }),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            });

          yield CreateOrderSuccessfulState(
              data: list_data,
              discount: state.discount,
              totalPrice: (totalPrice - totalPrice * state.discount).toInt());

      }
  }
}
