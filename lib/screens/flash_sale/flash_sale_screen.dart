import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlashSaleScreen extends StatefulWidget {
  @override
  _FlashSaleScreenState createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen> {
  late Timer _timer;
  int time = 23 * 3600;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) time--;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF34646),
          title: Text(
            "FLASH SALE",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xffE7E7E7),
        body: Column(
          children: [
            TabBar(
              indicatorColor: Color(0xffE7E7E7),
              tabs: [
                Container(
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "00:00",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffF34646),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Đang diễn ra",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffF34646),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )),
                ),
                Container(
                  child: Center(
                      child: Text(
                    "00:00",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF34646),
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ),
                Container(
                  child: Center(
                      child: Text(
                    "00:00",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF34646),
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ),
                Container(
                  child: Center(
                      child: Text(
                    "00:00",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF34646),
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ),
                Container(
                  child: Center(
                      child: Text(
                    "00:00",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF34646),
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "KẾT THÚC TRONG",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(1)),
                                  child: Text(
                                    (time ~/ 3600).toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(1)),
                                  child: Text(
                                    (time % 3600 ~/ 60) >= 10
                                        ? (time % 3600 ~/ 60).toString()
                                        : "0" + (time % 3600 ~/ 60).toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(1)),
                                  child: Text(
                                    (time % 60) >= 10
                                        ? (time % 60).toString()
                                        : "0" + (time % 60).toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Color(0xffF8BD00),
                                  size: 15,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Image.network(
                                    "https://play-lh.googleusercontent.com/hRq2DVKkzBXQkyftxr0e2ytl0fS2hEWx3UTe3V652RfJVYWqVRGgBNhmZgqNzJ8PKHE",
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.height / 3 -
                                            20,
                                    fit: BoxFit.fill,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ĐẦM BẦU PHỐI HOA VIỀN REN NỮ TÍNH 115 SID61193",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.5,
                                              height: 20),
                                          maxLines: null,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: "vi")
                                                  .format(315000)
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xffB8B6B6),
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "-" + "30" + "%",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffFE8E0B),
                                                  height: 20),
                                            ),
                                            Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: "vi")
                                                  .format(315000 * 0.3)
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xffF34646)),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
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
