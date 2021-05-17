import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/models/cart_item.dart' as cart;
import 'package:faiikan/models/order_item.dart';
import 'package:faiikan/screens/address_screen/select_address.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool haveAddress = false;

  String Voucher = "Chọn hoặc nhập voucher";
  late List<cart.CartItem> listItems;

  @override
  void initState() {
    // TODO: implement initState
//    listItems = context
//        .read<CartBloc>()
//        .list_data
//        .where((element) => element.isChosen)
//        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        title: Text(
          "Thanh toán",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: haveAddress
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.black.withOpacity(0.6),
                        size: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      haveAddress
                          ? Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
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
                                  "Nguyễn Quang Khang" + " | " + "0967524699",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Kí túc xá khu B - Đhqg tp.HCM",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Dĩ An - Đông Hòa - Bình Dương",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectAddressScreen())).then((value) {
                            setState(() {
                              haveAddress=true;
                            });
                          });
                        },
                            child: Text(
                                "Vui lòng chọn địa chỉ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                          ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black.withOpacity(0.6),
                    size: 15,
                  )
                ],
              ),
            ),
            Container(
              color: Color(0xffEDEDED),
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "Sản phẩm",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffEDEDED),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  itemCount: listItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: OrderItemCard(
                            orderItem: listItems[index],
                            index: index,
                            isOrderDetail: true,
                          ),
                        ),
                        Container(
                          color: Color(0xffEDEDED),
                          height: 5,
                        ),
                      ],
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "Đơn vị vận chuyển",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffEDEDED),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Giao hàng tiết kiệm",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Nhận hàng vào " + "05/04-10/04",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        NumberFormat.simpleCurrency(locale: "vi")
                            .format(20000)
                            .toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.black.withOpacity(0.6),
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xffEDEDED),
              height: 5,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(
                  top: 3,
                ),
                padding:
                    EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CustomIcon.voucher,
                              color: Color(0xffF87328),
                              size: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Voucher"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              Voucher,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.black.withOpacity(0.6),
                              size: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (Voucher != "Chọn hoặc nhập voucher")
                      Positioned(
                        right: 5,
                        child: Icon(
                          Icons.cancel,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ),
                  ],
                )),
            Container(
              color: Color(0xffEDEDED),
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Phương thức thanh toán",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Chọn phương thức \nthanh toán",
                        maxLines: null,
                        style: TextStyle(
                          color: Color(0xffEA1313).withOpacity(0.6),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.black.withOpacity(0.6),
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: Color(0xffEDEDED),
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng tiền hàng",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        NumberFormat.simpleCurrency(locale: "vi")
                            .format(20000)
                            .toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng tiền phí vận chuyển",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        NumberFormat.simpleCurrency(locale: "vi")
                            .format(context.read<CartBloc>().totalPrice)
                            .toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tiền khuyến mãi",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "-" +
                            NumberFormat.simpleCurrency(locale: "vi")
                                .format(20000)
                                .toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng thanh toán",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(locale: "vi")
                              .format(context.read<CartBloc>().totalPrice)
                              .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
