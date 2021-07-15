import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_event.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_state.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_bloc.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_event.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_state.dart';
import 'package:faiikan/models/cart_item.dart' as cartItem;
import 'package:faiikan/models/order.dart';
import 'package:faiikan/screens/my_order_screen/order_item_detail.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

List<String> list_status = [
  "Chờ xác nhận",
  "Đang xử lý",
  "Đang giao",
  "Đã giao",
  "Đã Hủy",
];

class MyOrderScreen extends StatefulWidget {
  final String userId;
  final int initialTab;
  MyOrderScreen({required this.userId,required this.initialTab });

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: list_status.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: list_status.length,
            initialIndex: widget.initialTab,
            child: Scaffold(
              backgroundColor: Color(0xffC4C4C4).withOpacity(0.5),
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
                textTheme: TextTheme(),
                backgroundColor: Colors.white,
                title: Text(
                  "Đơn hàng",
                  style: TextStyle(color: Colors.black),
                ),
                bottom: TabBar(
                  indicatorColor: Color(0xffDB4313),
                  labelColor: Color(0xffDB4313),
                  labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                  unselectedLabelColor: Colors.black,
                  isScrollable: true,
                  tabs: list_status.map<Widget>((value) {
                    return Tab(
                      text: value,
                    );
                  }).toList(),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TabBarView(
                  children: list_status.map<Widget>((value) {
                    return BlocProvider(
                      create: (_) =>
                      MyOrderBloc(LoadMyOrder())
                        ..add(InitiateMyOrderEvent(
                            person_id: widget.userId, status: value)),
                      child: MyOrder_TabPage(
                        status: value,
                        userId: widget.userId,
                      ),
                    );
                  }).toList(),
                ),
              ),
            )));
  }
}

class MyOrder_TabPage extends StatefulWidget {
  final String status;
  final String userId;
  MyOrder_TabPage({required this.status,required this.userId});

  List<bool> isExpanded = [];

  @override
  _MyOrder_TabPageState createState() => _MyOrder_TabPageState();
}

class _MyOrder_TabPageState extends State<MyOrder_TabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrderBloc, MyOrderState>(builder: (context, state) {
      if (state is InitialMyOrderState) {
        if (widget.isExpanded.isEmpty) {
          for (int a = 0; a < context
              .read<MyOrderBloc>()
              .myOrders
              .length; a++) {
            widget.isExpanded.add(false);
          }
        }
        if (context
            .read<MyOrderBloc>()
            .myOrders
            .isEmpty)
          return Container(color: Color(0xffC4C4C4).withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/images/emptyOrder.png",
              ),
              SizedBox(height: 5,),
              Text("Chưa có đơn hàng.", style: TextStyle(
                  letterSpacing: 0.5, color: Colors.black54, fontSize: 14),)

            ],),);
        return Container(
          color: Color(0xffC4C4C4).withOpacity(0.5),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Column(
                      children: List.generate(
                          context
                              .read<MyOrderBloc>()
                              .myOrders
                              .length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        BlocProvider(
                                          create: (_) =>
                                          OrderDetailBloc(LoadingOrderDetail())
                                            ..add(InitiateOrderDetailEvent(
                                                orderId: context
                                                    .read<MyOrderBloc>()
                                                    .myOrders[index]
                                                    .id!
                                                    .toString())),
                                          child: BlocProvider.value(
                                            value: context.read<MyOrderBloc>(),
                                            child: OrderDetailScreen(
                                              status: widget.status,
                                              userId: widget.userId,
                                              index: index,
                                              orderId: context.read<MyOrderBloc>().myOrders[index].id!.toString(),
                                            ),
                                          ),
                                        )));
                          },
                          child: Container(
                            margin: index != 0
                                ? EdgeInsets.only(
                                left: 0, bottom: 10, right: 0)
                                : EdgeInsets.only(
                                left: 0, bottom: 10, right: 0, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.black.withOpacity(0.5),
//                                  spreadRadius: 1,
//                                  blurRadius: 3,
//                                  offset: Offset(
//                                      0, 0), // changes position of shadow
//                                ),
//                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 2,
                                        child: Text(
                                          "Mã đơn hàng: " +
                                              context
                                                  .read<MyOrderBloc>()
                                                  .myOrders[index]
                                                  .id!
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff222222),
                                              fontWeight: FontWeight.w500),
                                          maxLines: null,
                                        ),
                                      ),
                                      Text(
                                        context
                                            .read<MyOrderBloc>()
                                            .myOrders[index]
                                            .status!,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffDB4313)),
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black12,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Column(
                                    children: [
                                      if (widget.isExpanded[index] == true)
                                        Column(
                                          children: List.generate(
                                              context
                                                  .read<MyOrderBloc>()
                                                  .myOrders[index]
                                                  .listItem!
                                                  .length, (i) {
                                            return Column(
                                              children: [
                                                OrderItemCard(
                                                  orderItem: new cartItem
                                                      .CartItem(
                                                      cartId: context
                                                          .read<MyOrderBloc>()
                                                          .myOrders[index]
                                                          .listItem![i]
                                                          .id!,
                                                      productId: context
                                                          .read<MyOrderBloc>()
                                                          .myOrders[index]
                                                          .listItem![i]
                                                          .productId!,
                                                      nameProduct: context
                                                          .read<MyOrderBloc>()
                                                          .myOrders[index]
                                                          .listItem![i]
                                                          .name!,
                                                      amount: context
                                                          .read<MyOrderBloc>()
                                                          .myOrders[index]
                                                          .listItem![i]
                                                          .quantity!,
                                                      optionProduct: new cartItem
                                                          .OptionProduct(
                                                          productOptionId: context
                                                              .read<
                                                              MyOrderBloc>()
                                                              .myOrders[index]
                                                              .listItem![i]
                                                              .productOptionId!,
                                                          price: new cartItem
                                                              .Price(
                                                              id: 0,
                                                              value: context
                                                                  .read<
                                                                  MyOrderBloc>()
                                                                  .myOrders[index]
                                                                  .listItem![i]
                                                                  .price!
                                                                  .toDouble()),
                                                          quantity: new cartItem
                                                              .Quantity(
                                                              id: 0,
                                                              value: context
                                                                  .read<
                                                                  MyOrderBloc>()
                                                                  .myOrders[index]
                                                                  .listItem![i]
                                                                  .quantity!),
                                                          color: new cartItem
                                                              .Color(
                                                              id: 0,
                                                              value: context
                                                                  .read<
                                                                  MyOrderBloc>()
                                                                  .myOrders[index]
                                                                  .listItem![i]
                                                                  .color ??
                                                                  ""),
                                                          size: new cartItem
                                                              .Size(
                                                              id: 0,
                                                              value:
                                                              context
                                                                  .read<
                                                                  MyOrderBloc>()
                                                                  .myOrders[index]
                                                                  .listItem![i]
                                                                  .size ??
                                                                  ""),
                                                          image: new cartItem
                                                              .Image(
                                                              id: 0,
                                                              value: context
                                                                  .read<
                                                                  MyOrderBloc>()
                                                                  .myOrders[index]
                                                                  .listItem![i]
                                                                  .imageUrl!))),
                                                  isOrderDetail: true,
                                                  index: 0,
                                                  userId: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                if (context
                                                    .read<MyOrderBloc>()
                                                    .myOrders[index]
                                                    .listItem!
                                                    .length >
                                                    1 &&
                                                    widget.isExpanded[index] ==
                                                        false)
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1,
                                                            ),
                                                            top: BorderSide(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1,
                                                            ))),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 5),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          widget
                                                              .isExpanded[index] =
                                                          true;
                                                        });
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          "Xem thêm sản phẩm",
                                                          style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.5),
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
                                            );
                                          }),
                                        )
                                      else
                                        Column(
                                          children: [
                                            OrderItemCard(
                                              orderItem: new cartItem.CartItem(
                                                  cartId: context
                                                      .read<MyOrderBloc>()
                                                      .myOrders[index]
                                                      .listItem![0]
                                                      .id!,
                                                  productId: context
                                                      .read<MyOrderBloc>()
                                                      .myOrders[index]
                                                      .listItem![0]
                                                      .productId!,
                                                  nameProduct: context
                                                      .read<MyOrderBloc>()
                                                      .myOrders[index]
                                                      .listItem![0]
                                                      .name!,
                                                  amount: context
                                                      .read<MyOrderBloc>()
                                                      .myOrders[index]
                                                      .listItem![0]
                                                      .quantity!,
                                                  optionProduct: new cartItem
                                                      .OptionProduct(
                                                      productOptionId: context
                                                          .read<MyOrderBloc>()
                                                          .myOrders[index]
                                                          .listItem![0]
                                                          .productOptionId!,
                                                      price: new cartItem.Price(
                                                          id: 0,
                                                          value: context
                                                              .read<
                                                              MyOrderBloc>()
                                                              .myOrders[index]
                                                              .listItem![0]
                                                              .price!
                                                              .toDouble()),
                                                      quantity: new cartItem
                                                          .Quantity(
                                                          id: 0,
                                                          value: context
                                                              .read<
                                                              MyOrderBloc>()
                                                              .myOrders[index]
                                                              .listItem![0]
                                                              .quantity!),
                                                      color: new cartItem.Color(
                                                          id: 0,
                                                          value: context
                                                              .read<
                                                              MyOrderBloc>()
                                                              .myOrders[index]
                                                              .listItem![0]
                                                              .color ??
                                                              ""),
                                                      size: new cartItem.Size(
                                                          id: 0,
                                                          value: context
                                                              .read<
                                                              MyOrderBloc>()
                                                              .myOrders[index]
                                                              .listItem![0]
                                                              .size ??
                                                              ""),
                                                      image:
                                                      new cartItem.Image(
                                                          id: 0, value: context
                                                          .read<MyOrderBloc>()
                                                          .myOrders[index]
                                                          .listItem![0]
                                                          .imageUrl!))),
                                              isOrderDetail: true,
                                              index: 0,
                                              userId: 1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            if (context
                                                .read<MyOrderBloc>()
                                                .myOrders[index]
                                                .listItem!
                                                .length >
                                                1 &&
                                                widget.isExpanded[index] ==
                                                    false)
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                          color: Colors.black12,
                                                          width: 1,
                                                        ),
                                                        top: BorderSide(
                                                          color: Colors.black12,
                                                          width: 1,
                                                        ))),
                                                padding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      widget.isExpanded[index] =
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
                                                        fontWeight: FontWeight
                                                            .w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Số Lượng: ",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff9B9B9B)),
                                                ),
                                                Text(
                                                  context
                                                      .read<MyOrderBloc>()
                                                      .myOrders[index]
                                                      .listItem!
                                                      .length
                                                      .toString() +
                                                      " sản phẩm",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff222222),
                                                      fontWeight: FontWeight
                                                          .w400),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Tổng tiền: ",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff9B9B9B)),
                                                ),
                                                Text(
                                                  NumberFormat.simpleCurrency(
                                                      locale: "vi")
                                                      .format(context
                                                      .read<MyOrderBloc>()
                                                      .myOrders[index]
                                                      .grandPrice)
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xffF34646),
                                                      fontWeight: FontWeight
                                                          .w600),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
                ],
              )),
        );
      }
      return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.redAccent,
          ));
    });
  }
}
