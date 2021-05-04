import 'package:faiikan/models/order.dart';
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order orderDetail;

  const OrderDetailScreen({
    required this.orderDetail,
  });

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
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: <Widget>[],
        textTheme: TextTheme(),
        backgroundColor: Color(0xFF4ab3b5),
        title: Text(
          "Order Detail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Mã đơn hàng: " + orderDetail.id,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy")
                            .format(DateTime.parse(orderDetail.createDate)),
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff9B9B9B)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    orderDetail.deliveryStatus,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffDB4313),
                        fontWeight: FontWeight.w400),
                  ),
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                orderDetail.listOrderItem.length.toString() + " sản phẩm",
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
              height: MediaQuery.of(context).size.height / 2 + 10,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ListView.builder(
                  itemCount: orderDetail.listOrderItem.length,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 15),
                      child: Stack(
                        children: <Widget>[
                          OrderItemCard(
                            index: index,
                            orderItem: orderDetail.listOrderItem[index],
                            isOrderDetail: true,
                          ),
                          if (orderDetail.deliveryStatus == "Đã giao" &&
                              orderDetail.listOrderItem[index].isReview ==
                                  false)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => AddReviewScreen(OrderItemId: orderDetail.listOrderItem[index].id,)
//                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
            Container(
              height: 5,
              color: Colors.black12,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Địa chỉ giao hàng: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff9B9B9B),
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Text(
                          orderDetail.address,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Phương pháp thanh toán: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff9B9B9B),
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Text(
                          orderDetail.methodPayment,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            .format(orderDetail.priceShip)
                            .toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Khuyến mãi: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff9B9B9B),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "10%",
                        maxLines: null,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tổng cộng: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff9B9B9B),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        NumberFormat.simpleCurrency(locale: "vi")
                            .format(orderDetail.totalPrice)
                            .toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffDB3022),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "Đặt hàng lại ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: "Roboto"),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
