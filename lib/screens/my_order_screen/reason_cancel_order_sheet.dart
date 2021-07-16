import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReasonCancelOrderSheet extends StatefulWidget {
  final int index;
  final String orderId;

  const ReasonCancelOrderSheet(
      {Key? key, required this.index, required this.orderId})
      : super(key: key);

  @override
  _ReasonCancelOrderSheetState createState() => _ReasonCancelOrderSheetState();
}

class _ReasonCancelOrderSheetState extends State<ReasonCancelOrderSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 3,
          margin: EdgeInsets.all(10),
          color: Color(0xffC4C4C4),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Lý do hủy đơn",
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listReasons.length,
                      itemBuilder: (context, i) => Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: checkboxValue[i],
                              shape: CircleBorder(),
                              onChanged: (value) {
                                setState(() {
                                  checkboxValue[i] = value!;
                                });
                              },
                              activeColor: Color(0xffF34646),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                listReasons[i],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    letterSpacing: 0.5),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.only(bottom: 2,top: 10, left: 10, right: 10),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 0))
          ]),
          child: InkWell(
            onTap: () {
              if (checkboxValue.where((element) => element == true).isNotEmpty)  {
                context.read<MyOrderBloc>().add(UpdateSttMyOrderEvent(
                    orderId: widget.orderId, status: "5", index: widget.index));
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(3)),
              child: Center(
                child: Text(
                  "Hủy đơn",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

List<bool> checkboxValue = [
  false,
  false,
  false,
  false,
  false,
  false,
];
List<String> listReasons = [
  "Muốn thay đổi địa chỉ giao hàng",
  "Muốn nhập/thay đổi mã Vourcher",
  "Muốn thay đổi sản phẩm trong đơn hàng (size, màu sắc, số lượng,...",
  "Thủ tục thanh toán quá rắc rối",
  "Tìm thấy giá rẻ hơn ở chỗ khác",
  "Đổi ý không muốn mua nữa",
];
