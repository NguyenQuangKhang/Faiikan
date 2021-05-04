import 'package:faiikan/screens/address_screen/new_address.dart';
import 'package:flutter/material.dart';

class MyAddressScreen extends StatelessWidget {
  int defaultIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Địa chỉ của tôi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewAddressScreen()));
            },
            child: Center(
              child: Text(
                "Thêm",
                style: TextStyle(
                  color: Color(0xff0E8D39),
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
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
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Color(0xffC4C4C4).withOpacity(0.5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 1,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Nhấn vào địa chỉ để sửa",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 1,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 10,
                              direction: Axis.vertical,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Địa chỉ nhận hàng",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    if (index == defaultIndex)
                                      Text(
                                        "[Mặc định]",
                                        style: TextStyle(
                                          color: Color(0xffF83434),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                  ],
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 5,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
