import 'package:faiikan/models/order_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CartEvent.dart';
import 'CartState.dart';

List<OrderItem> list = [
  new OrderItem(
      "1",
      "Áo xyz",
      'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
      120000,
      1,
      "M",
      "color"),
  new OrderItem(
      "1",
      "Áo xyz",
      'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
      120000,
      1,
      "M",
      "color"),
  new OrderItem(
      "1",
      "Áo xyz",
      'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
      120000,
      1,
      "M",
      "color"),
  new OrderItem(
      "1",
      "Áo xyz",
      'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
      120000,
      1,
      "M",
      "color"),
  new OrderItem(
      "1",
      "Áo xyz",
      'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
      120000,
      1,
      "M",
      "color"),
  new OrderItem(
      "1",
      "Áo xyz",
      'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
      120000,
      1,
      "M",
      "color"),
  new OrderItem(
      "1",
      "Áo xyz",
      'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
      120000,
      1,
      "M",
      "color"),
  new OrderItem(
    "1",
    "Áo xyz",
    'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg',
    120000,
    1,
    "M",
    "color",
  ),
];

class CartBloc extends Bloc<CartEvent, CartState> {
  List<OrderItem> list_data = [];
  late double totalPrice = 0;
  late double discount;

  CartBloc(CartState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  CartState get initialState => Initial(data: [], discount: 0, totalPrice: 0);

  @override
  Stream<CartState> mapEventToState(event) async* {
    if (event is GetCartEvent) {
      list_data = list;

      yield CartLoadedState(
          data: list_data,
          discount: state.discount,
          totalPrice: (totalPrice - totalPrice * state.discount).toInt());
    }
    if (event is UpdateCartEvent) {
      yield CartLoadingState(data: list_data,
          discount: state.discount,
          totalPrice: (totalPrice - totalPrice * state.discount).toInt());
      totalPrice += (event.amount - list_data[event.index].count) *
          list_data[event.index].productPrice;
      list_data[event.index].count = event.amount;
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

    if (event is DeleteCartEvent) {
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
    if (event is CheckItemCartEvent) {
      list_data[event.index].isChosen = event.value;

      totalPrice = 0;
      for (int i = 0; i < list_data.length; i++) {
        if (list_data[i].isChosen == true) {
          totalPrice += list_data[i].count * list_data[i].productPrice;
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
          totalPrice += list_data[i].count * list_data[i].productPrice;
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
  }
}
