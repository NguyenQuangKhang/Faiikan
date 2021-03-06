import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_bloc.dart';
import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_event.dart';
import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_state.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_bloc.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/models/order_detail.dart';
import 'package:faiikan/screens/my_order_screen/reason_cancel_order_detail.dart';
import 'package:faiikan/screens/my_order_screen/reason_cancel_order_sheet.dart';
import 'package:faiikan/screens/payment_screen/payment_screen.dart';
import 'package:faiikan/screens/review_screen/create_review_screen.dart';
import 'package:faiikan/models/cart_item.dart' as cartItem;
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import 'order_item_rating_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  final int index;
  final String orderId;
  final String status;
  final String userId;
  List<bool> isExpanded = [];

  OrderDetailScreen({
    required this.status,
    required this.userId,
    required this.index,
    required this.orderId,
  });

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.status);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          actions: <Widget>[],
          textTheme: TextTheme(),
          backgroundColor: Color(0xFFffffff),
          title: Text(
            "Chi ti???t ????n h??ng",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
          builder: (context, state) {
            if (state is LoadingOrderDetail)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                ),
              );
            if (widget.isExpanded.isEmpty) {
              for (int a = 0;
                  a <
                      context
                          .read<OrderDetailBloc>()
                          .orderDetail
                          .listItem!
                          .length;
                  a++) {
                widget.isExpanded.add(false);
              }
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "M?? ????n h??ng: " +
                                        context
                                            .read<OrderDetailBloc>()
                                            .orderDetail
                                            .id!
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff222222),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    context
                                        .read<OrderDetailBloc>()
                                        .orderDetail
                                        .createdAt!
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff9B9B9B)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
//                            Text(
//                              context.read<OrderDetailBloc>().orderDetail.,
//                              style: TextStyle(
//                                  fontSize: 14,
//                                  color: Color(0xffDB4313),
//                                  fontWeight: FontWeight.w400),
//                            ),
                            ],
                          ),
                        ),
                        Container(
                          height: 5,
                          color: Colors.black12,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            context
                                    .read<OrderDetailBloc>()
                                    .orderDetail
                                    .listItem!
                                    .length
                                    .toString() +
                                " s???n ph???m",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3A1DEC)),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black26,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
//                          height: MediaQuery.of(context).size.height / 2 + 10,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: List.generate(
                                context
                                    .read<OrderDetailBloc>()
                                    .orderDetail
                                    .listItem!
                                    .length, (i) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        if (widget.isExpanded[i] == true)
                                          Column(
                                            children: List.generate(
                                                context
                                                    .read<OrderDetailBloc>()
                                                    .orderDetail
                                                    .listItem!
                                                    .length, (i) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: OrderItemCard(
                                                      orderItem: new cartItem.CartItem(
                                                          cartId: context
                                                              .read<
                                                                  OrderDetailBloc>()
                                                              .orderDetail
                                                              .listItem![i]
                                                              .id!,
                                                          productId: context
                                                              .read<
                                                                  OrderDetailBloc>()
                                                              .orderDetail
                                                              .listItem![i]
                                                              .productId!,
                                                          nameProduct: context
                                                              .read<
                                                                  OrderDetailBloc>()
                                                              .orderDetail
                                                              .listItem![i]
                                                              .name!,
                                                          amount: context
                                                              .read<
                                                                  OrderDetailBloc>()
                                                              .orderDetail
                                                              .listItem![i]
                                                              .quantity!,
                                                          optionProduct: new cartItem
                                                                  .OptionProduct(
                                                              productOptionId: context
                                                                  .read<
                                                                      OrderDetailBloc>()
                                                                  .orderDetail
                                                                  .listItem![i]
                                                                  .productOptionId!,
                                                              price: new cartItem.Price(
                                                                  id: 0,
                                                                  value: context
                                                                      .read<
                                                                          OrderDetailBloc>()
                                                                      .orderDetail
                                                                      .listItem![
                                                                          i]
                                                                      .price!
                                                                      .toDouble()),
                                                              quantity: new cartItem.Quantity(
                                                                  id: 0,
                                                                  value: context
                                                                      .read<OrderDetailBloc>()
                                                                      .orderDetail
                                                                      .listItem![i]
                                                                      .quantity!),
                                                              color: new cartItem.Color(id: 0, value: context.read<OrderDetailBloc>().orderDetail.listItem![i].color ?? ""),
                                                              size: new cartItem.Size(id: 0, value: context.read<OrderDetailBloc>().orderDetail.listItem![i].size ?? ""),
                                                              image: new cartItem.Image(id: 0, value: context.read<OrderDetailBloc>().orderDetail.listItem![i].imageUrl!))),
                                                      isOrderDetail: true,
                                                      index: 0,
                                                      userId: 1,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  if (context
                                                              .read<
                                                                  OrderDetailBloc>()
                                                              .orderDetail
                                                              .listItem!
                                                              .length >
                                                          1 &&
                                                      widget.isExpanded[i] ==
                                                          false)
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black12,
                                                                width: 1,
                                                              ),
                                                              top: BorderSide(
                                                                color: Colors
                                                                    .black12,
                                                                width: 1,
                                                              ))),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            widget.isExpanded[
                                                                i] = true;
                                                          });
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            "Xem th??m sa??n ph????m",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          )
                                        else
                                          Column(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: OrderItemCard(
                                                  orderItem: new cartItem.CartItem(
                                                      cartId: context
                                                          .read<
                                                              OrderDetailBloc>()
                                                          .orderDetail
                                                          .listItem![0]
                                                          .id!,
                                                      productId: context
                                                          .read<
                                                              OrderDetailBloc>()
                                                          .orderDetail
                                                          .listItem![0]
                                                          .productId!,
                                                      nameProduct: context
                                                          .read<
                                                              OrderDetailBloc>()
                                                          .orderDetail
                                                          .listItem![0]
                                                          .name!,
                                                      amount: context
                                                          .read<
                                                              OrderDetailBloc>()
                                                          .orderDetail
                                                          .listItem![0]
                                                          .quantity!,
                                                      optionProduct: new cartItem.OptionProduct(
                                                          productOptionId: context
                                                              .read<
                                                                  OrderDetailBloc>()
                                                              .orderDetail
                                                              .listItem![0]
                                                              .productOptionId!,
                                                          price: new cartItem.Price(
                                                              id: 0,
                                                              value: context
                                                                  .read<
                                                                      OrderDetailBloc>()
                                                                  .orderDetail
                                                                  .listItem![0]
                                                                  .price!
                                                                  .toDouble()),
                                                          quantity: new cartItem.Quantity(
                                                              id: 0,
                                                              value: context
                                                                  .read<
                                                                      OrderDetailBloc>()
                                                                  .orderDetail
                                                                  .listItem![0]
                                                                  .quantity!),
                                                          color: new cartItem.Color(
                                                              id: 0,
                                                              value: context.read<OrderDetailBloc>().orderDetail.listItem![0].color ?? ""),
                                                          size: new cartItem.Size(id: 0, value: context.read<OrderDetailBloc>().orderDetail.listItem![0].size ?? ""),
                                                          image: new cartItem.Image(id: 0, value: context.read<OrderDetailBloc>().orderDetail.listItem![0].imageUrl!))),
                                                  isOrderDetail: true,
                                                  index: 0,
                                                  userId: 1,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              if (context
                                                          .read<
                                                              OrderDetailBloc>()
                                                          .orderDetail
                                                          .listItem!
                                                          .length >
                                                      1 &&
                                                  widget.isExpanded[i] == false)
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            width: 1,
                                                          ),
                                                          top: BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            width: 1,
                                                          ))),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        widget.isExpanded[i] =
                                                            true;
                                                      });
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        "Xem th??m sa??n ph????m",
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontSize: 12,
                                                          letterSpacing: 0.5,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        Container(
                                          height: 1,
                                          color: Color(0xffC4C4C4),
                                        )
                                      ],
                                    ),
                                    if (widget.status == "???? giao")
                                      Positioned(
                                        bottom: 20,
                                        right: 10,
                                        child: InkWell(
                                          onTap: () {
                                            if (context
                                                    .read<OrderDetailBloc>()
                                                    .orderDetail
                                                    .listItem![i]
                                                    .reviewStatus ==
                                                false) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          BlocProvider.value(
                                                            value: context.read<
                                                                OrderDetailBloc>(),
                                                            child:
                                                                CreateReviewScreen(
                                                              orderDetail: context
                                                                  .read<
                                                                      OrderDetailBloc>()
                                                                  .orderDetail,
                                                              userId:
                                                                  widget.userId,
                                                              index: i,
                                                            ),
                                                          )));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          BlocProvider(
                                                            create: (_) => OrderItemRatingBloc(
                                                                LoadOrderItemRating())
                                                              ..add(InitiateOrderItemRatingEvent(
                                                                  person_id:
                                                                      widget
                                                                          .userId,
                                                                  productOptionId:
                                                                      context.read<
                                                                          OrderDetailBloc>().orderDetail.listItem![i].productOptionId!.toString(),
                                                                  productId:
                                                                  context.read<
                                                                      OrderDetailBloc>().orderDetail.listItem![i].productId!.toString())),
                                                            child:
                                                                OrderItemRatingScreen(userId: widget.userId,)
                                                          )));
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Color(0xffDB3022),
                                            ),
                                            child: Center(
                                              child: Text(
                                                context
                                                            .read<
                                                                OrderDetailBloc>()
                                                            .orderDetail
                                                            .listItem![i]
                                                            .reviewStatus ==
                                                        false
                                                    ? "????nh gi??"
                                                    : "Xem ??a??nh gia??",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        Container(
                          height: 5,
                          color: Colors.black12,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "Th??ng tin ????n h??ng",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3A1DEC)),
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
//                                Text(
//                                  "?????a ch??? giao h??ng: ",
//                                  style: TextStyle(
//                                      fontSize: 14,
//                                      color: Color(0xff9B9B9B),
//                                      fontWeight: FontWeight.w500),
//                                ),
//                                SizedBox(height: 10,),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    spacing: 10,
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        "??i??a chi?? nh????n ha??ng",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        context
                                                .read<OrderDetailBloc>()
                                                .orderDetail
                                                .address!
                                                .name! +
                                            " | " +
                                            context
                                                .read<OrderDetailBloc>()
                                                .orderDetail
                                                .address!
                                                .numberPhone!,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        context
                                            .read<OrderDetailBloc>()
                                            .orderDetail
                                            .address!
                                            .specificAddress!,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        context
                                                .read<OrderDetailBloc>()
                                                .orderDetail
                                                .address!
                                                .ward!
                                                .prefix! +
                                            " " +
                                            context
                                                .read<OrderDetailBloc>()
                                                .orderDetail
                                                .address!
                                                .ward!
                                                .name! +
                                            " - " +
                                            context
                                                .read<OrderDetailBloc>()
                                                .orderDetail
                                                .address!
                                                .district!
                                                .prefix! +
                                            " " +
                                            context
                                                .read<OrderDetailBloc>()
                                                .orderDetail
                                                .address!
                                                .district!
                                                .name! +
                                            " - " +
                                            context
                                                .read<OrderDetailBloc>()
                                                .orderDetail
                                                .address!
                                                .province!
                                                .name!,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 5,
                                color: Color(0xffC4C4C4).withOpacity(0.5),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Ph????ng th????c thanh to??n: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Text(
                                      context
                                          .read<OrderDetailBloc>()
                                          .orderDetail
                                          .payment!
                                          .name!,
                                      maxLines: null,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff222222),
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Ph?? Ship: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff9B9B9B),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    NumberFormat.simpleCurrency(locale: "vi")
                                        .format(context
                                            .read<OrderDetailBloc>()
                                            .orderDetail
                                            .shippingFee!)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff9B9B9B),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Khuy???n m??i: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff9B9B9B),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    NumberFormat.simpleCurrency(locale: "vi")
                                        .format(context
                                            .read<OrderDetailBloc>()
                                            .orderDetail
                                            .discount!)
                                        .toString(),
                                    maxLines: null,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff9B9B9B),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "T???ng c???ng: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    NumberFormat.simpleCurrency(locale: "vi")
                                        .format(context
                                            .read<OrderDetailBloc>()
                                            .orderDetail
                                            .grandPrice!)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff222222),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 5,
                          color: Color(0xffC4C4C4).withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "M?? ????n h??ng",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                          .read<OrderDetailBloc>()
                                          .orderDetail
                                          .id!
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.status == "??a?? hu??y"
                                          ? "Th????i gian hu??y ????n"
                                          : "Th???i gian ?????t h??ng",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff9B9B9B),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                              .read<OrderDetailBloc>()
                                              .orderDetail
                                              .payAt ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff9B9B9B),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Th???i gian thanh to??n",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff9B9B9B),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                              .read<OrderDetailBloc>()
                                              .orderDetail
                                              .payAt ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff9B9B9B),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
//                              Padding(
//                                padding: EdgeInsets.symmetric(vertical: 5),
//                                child: Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: [
//                                    Text(
//                                      "Th???i gian giao h??ng cho v???n chuy???n",
//                                      style: TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xff9B9B9B),
//                                          fontWeight: FontWeight.w500),
//                                    ),
//                                    Text(
//                                      "15-06-2021",
//                                      style: TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xff9B9B9B),
//                                          fontWeight: FontWeight.w500),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.symmetric(vertical: 5),
//                                child: Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: [
//                                    Text(
//                                      "Th???i gian ho??n th??nh",
//                                      style: TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xff9B9B9B),
//                                          fontWeight: FontWeight.w500),
//                                    ),
//                                    Text(
//                                      "15-06-2021",
//                                      style: TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xff9B9B9B),
//                                          fontWeight: FontWeight.w500),
//                                    ),
//                                  ],
//                                ),
//                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) /
                                          2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      )),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "Chat v????i Admin",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.status == "Ch??? xa??c nh????n")
                                InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10),
                                              bottom: Radius.circular(10)),
                                        ),
                                        builder: (_) {
                                          return BlocProvider.value(
                                              value:
                                                  context.read<MyOrderBloc>(),
                                              child: ReasonCancelOrderSheet(
                                                orderId: widget.orderId,
                                                index: widget.index,
                                              ));
                                        }).then((value) {});
                                  },
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) /
                                        2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: Text(
                                        "H???y ????n h??ng",
                                        style: TextStyle(
                                            fontSize: 16, letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              if (widget.status == "??a?? hu??y")
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ReasonCancelOrderDetail()));
                                  },
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) /
                                        2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        )),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Center(
                                      child: Text(
                                        "Chi ti???t h???y ????n",
                                        style: TextStyle(
                                            fontSize: 16, letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.status == "???? giao" || widget.status == "??a?? hu??y")
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                  value: context.read<CartBloc>(),
                                  child: BlocProvider.value(
                                      value: context.read<ProductBloc>(),
                                      child: BlocProvider.value(
                                          value: context.read<AccountBloc>(),
                                          child: BlocProvider(
                                            create: (_) =>
                                                AddressBloc(LoadAddress())
                                                  ..add(InitialAddressEvent(
                                                      userId: widget.userId
                                                          .toString())),
                                            child: PaymentScreen(
                                                userId: widget.userId,
                                                listItems:
                                                    changeListItemstoCartItems(
                                                        context
                                                            .read<
                                                                OrderDetailBloc>()
                                                            .orderDetail
                                                            .listItem!)),
                                          ))))));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 0))
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffDB3022),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          "Mua l???i ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: "Roboto"),
                        )),
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 0))
                      ],
                    ),
//                    padding: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffC4C4C4).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        "??ang Ch???",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                            fontFamily: "Roboto"),
                      )),
                    ),
                  ),
              ],
            );
          },
        ));
  }
}

List<cartItem.CartItem> changeListItemstoCartItems(List<ListItem> listItems) {
  List<cartItem.CartItem> listData = [];
  for (int i = 0; i < listItems.length; i++) {
    listData.add(new cartItem.CartItem(
        cartId: 0,
        productId: listItems[i].productId!,
        nameProduct: "",
        amount: listItems[i].quantity!,
        optionProduct: new cartItem.OptionProduct(
            productOptionId: listItems[i].productOptionId!,
            price: new cartItem.Price(id: 0, value: listItems[i].price!),
            quantity:
                new cartItem.Quantity(id: 0, value: listItems[i].quantity!),
            color: new cartItem.Color(id: 0, value: listItems[i].color ?? ""),
            size: new cartItem.Size(id: 0, value: listItems[i].size ?? ""),
            image: new cartItem.Image(id: 0, value: listItems[i].imageUrl!))));
  }
  return listData;
}
