import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReasonCancelOrderSheet extends StatefulWidget {
  @override
  _ReasonCancelOrderSheetState createState() => _ReasonCancelOrderSheetState();
}

class _ReasonCancelOrderSheetState extends State<ReasonCancelOrderSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  Stack(
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Text(
                              "Chọn lý do hủy",
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CloseButton(
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  for (int i = 0; i < listReasons.length; i++)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Checkbox(
                        value: checkboxValue[i],
                        onChanged: (value) {
                          setState(() {
                            checkboxValue[i] = value!;
                          });
                        },
                        activeColor: Color(0xffF34646),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 0))
          ]),
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: (){

            },
            child: Container(
              decoration: BoxDecoration(
                  color:
                      checkboxValue.where((element) => element == true).length > 0
                          ? Colors.redAccent
                          : Color(0xffC4C4C4).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(3)),
              child: Center(
                child: Text(
                  "Đồng ý",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color:
                        checkboxValue.where((element) => element == true).length >
                                0
                            ? Colors.white
                            : Colors.grey,
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
