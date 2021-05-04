import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_address.dart';

class SelectAddressScreen extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddressScreen> {
  int selected=0;
  int defaultIndex=0;
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
          "Chọn địa chỉ nhận hàng",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyAddressScreen()
                  ));
            },
            child: Center(
              child: Text(
                "Sửa",
                style: TextStyle(
                  color: Color(0xffFE3C3C),
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(scrollDirection: Axis.vertical,itemCount: 2,itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  setState(() {
                    selected=index;
                  });
                },
                child: Column(
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
                                  if(index==defaultIndex) Text(
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
                         if(index==selected) Icon(
                            Icons.done_sharp,
                            size: 25,
                            color: Color(0xffF62D2D),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(height: 5,color: Colors.black.withOpacity(0.2),)
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
