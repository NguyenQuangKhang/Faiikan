import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_state.dart';
import 'package:faiikan/models/order.dart';
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'order_detail_screen.dart';

List<String> list_status = [
  "Chờ xác nhận",
  "Chờ lấy hàng",
  "Đang giao",
  "Đã giao",
  "Đã Hủy",
  "Trả hàng",
];

class MyOrderScreen extends StatefulWidget {
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
    return BlocBuilder<MyOrderBloc, MyOrderState>(builder: (context, state) {
      if (state is InitialMyOrderState)
        return MaterialApp(
            home: DefaultTabController(
                length: list_status.length,
                child: Scaffold(
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
                      children: context
                          .read<MyOrderBloc>()
                          .list_status_items
                          .map<Widget>((value) {
                        return MyOrder_TabPage(
                          list_orders: value,
                        );
                      }).toList(),
                    ),
                  ),
                )));
      return Center(child: CircularProgressIndicator());
    });
  }
}

class MyOrder_TabPage extends StatelessWidget {
  final List<Order> list_orders;

  const MyOrder_TabPage({required this.list_orders});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Column(
                children: List.generate(list_orders.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(
                                orderDetail: list_orders[index],
                              )));
                },
                child: Container(
                  margin: index != 0
                      ? EdgeInsets.only(left: 10, bottom: 10, right: 10)
                      : EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "ID: " + list_orders[index].id,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff222222),
                                    fontWeight: FontWeight.w500),
                                maxLines: null,
                              ),
                            ),
                            Text(
                              DateFormat("dd-MM-yyyy").format(
                                  DateTime.parse(list_orders[index].createDate)),
                              style:
                                  TextStyle(fontSize: 12, color: Color(0xff9B9B9B)),
                              maxLines: null,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Column(
                          children: [
                            OrderItemCard(
                              orderItem: list_orders[index].listOrderItem[0],
                              index: index,
                              isOrderDetail: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (list_orders[index].listOrderItem.length > 1)
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
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    "Xem thêm sản phẩm",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),

                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Số Lượng: ",
                                        style: TextStyle(
                                            fontSize: 12, color: Color(0xff9B9B9B)),
                                      ),
                                      Text(
                                        list_orders[index]
                                            .listOrderItem
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff222222),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Tổng tiền: ",
                                        style: TextStyle(
                                            fontSize: 12, color: Color(0xff9B9B9B)),
                                      ),
                                      Text(
                                        NumberFormat.simpleCurrency(locale: "vi")
                                            .format(list_orders[index].totalPrice)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff222222),
                                            fontWeight: FontWeight.w400),
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
        ));
  }
}
