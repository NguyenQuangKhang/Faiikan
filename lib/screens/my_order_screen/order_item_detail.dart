import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_bloc.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_state.dart';
import 'package:faiikan/models/order_detail.dart';
import 'package:faiikan/screens/my_order_screen/reason_cancel_order_detail.dart';
import 'package:faiikan/screens/my_order_screen/reason_cancel_order_sheet.dart';
import 'package:faiikan/screens/review_screen/create_review_screen.dart';
import 'package:faiikan/models/cart_item.dart' as cartItem;
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

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
            "Chi tiết đơn hàng",
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
                                    "Mã đơn hàng: " +
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
                                    DateFormat("dd-MM-yyyy").format(
                                        DateTime.parse(context
                                            .read<OrderDetailBloc>()
                                            .orderDetail
                                            .createdAt!)),
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
                                " sản phẩm",
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
                                                            "Xem thêm sản phẩm",
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
                                                        "Xem thêm sản phẩm",
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
//                                    if (widget.status ==
//                                        "Đã giao" /*&&
//                                            orderDetail.listOrderItem[index].isReview ==
//                                                false*/
//                                    )
                                    Positioned(
                                      bottom: 20,
                                      right: 10,
                                      child: InkWell(
                                        onTap: () {
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
                                                          userId: widget.userId,
                                                          index: i,
                                                        ),
                                                      )));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Color(0xffDB3022),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Đánh giá",
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
                            "Thông tin đơn hàng",
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
//                                  "Địa chỉ giao hàng: ",
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
                                        "Địa chỉ nhận hàng",
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
                                    "Phương thức thanh toán: ",
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
                                    "Phí Ship: ",
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
                                    "Khuyến mãi: ",
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
                                    "Tổng cộng: ",
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
                                      "Mã đơn hàng",
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
                                      widget.status == "Đã hủy"
                                          ? "Thời gian hủy đơn"
                                          : "Thời gian đặt hàng",
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
                                      "Thời gian thanh toán",
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
//                                      "Thời gian giao hàng cho vận chuyển",
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
//                                      "Thời gian hoàn thành",
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
                        Wrap(
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
                                    "Chat với Admin",
                                    style: TextStyle(
                                        fontSize: 16, letterSpacing: 0.5),
                                  ),
                                ),
                              ),
                            ),
                            if (widget.status == "Đã giao")
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "Xem đánh giá",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.status == "Chờ xác nhận" || widget.status == "Chờ lấy hàng")
                              InkWell(
                                onTap: () async {
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return BlocProvider.value(value: context.read<MyOrderBloc>(), child: ReasonCancelOrderSheet(orderId: widget.orderId,index: widget.index,));
                                      }).then((value) {});
                                },
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "Hủy đơn hàng",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.status == "Đã hủy")
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ReasonCancelOrderDetail()));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      )),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "Chi tiết hủy đơn",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.status == "Đã giao" || widget.status == "Đã hủy")
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
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffDB3022),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        "Mua lại ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: "Roboto"),
                      )),
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
                        "Đang Chờ",
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
