import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyReviewScreen extends StatefulWidget {
  @override
  _MyReviewScreenState createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Đánh giá của tôi",
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
            color: Colors.black
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            color: Color(0xff24C3A1),
            padding: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Color(0xff24C3A1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "5.0",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RatingBarIndicator(
                    rating: 5.0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    itemCount: 5,
                    itemSize: 15,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Wrap(
              spacing: 15,
              direction: Axis.horizontal,
              runSpacing: 5,
              children: List.generate(6, (index) {
                if (index == 0) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(padding: EdgeInsets.all(10),
                      width:
                      (MediaQuery.of(context).size.width - 50) /
                          3,
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color(0xff24C3A1)
                              : Color(0xffC4C4C4).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2)),
                      child: Center(
                        child: Text(
                          "Tất cả" + "(11)",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                if (index == 1) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(padding: EdgeInsets.all(10),
                      width:
                      (MediaQuery.of(context).size.width - 50) /
                          3,
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color(0xff24C3A1)
                              : Color(0xffC4C4C4).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2)),
                      child: Center(
                        child: Text(
                          "5 sao" + "(11)",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                if (index == 2) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(padding: EdgeInsets.all(10),
                      width:
                      (MediaQuery.of(context).size.width - 50) /
                          3,
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color(0xff24C3A1)
                              : Color(0xffC4C4C4).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2)),
                      child: Center(
                        child: Text(
                          "4 sao" + "(11)",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                if (index == 3) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(padding: EdgeInsets.all(10),
                      width:
                      (MediaQuery.of(context).size.width - 50) /
                          3,
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color(0xff24C3A1)
                              : Color(0xffC4C4C4).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2)),
                      child: Center(
                        child: Text(
                          "3 sao" + "(11)",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                if (index == 4) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width:
                      (MediaQuery.of(context).size.width - 50) /
                          3,
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color(0xff24C3A1)
                              : Color(0xffC4C4C4).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2)),
                      child: Center(
                        child: Text(
                          "2 sao" + "(11)",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width:
                    (MediaQuery.of(context).size.width - 50) /
                        3,
                    decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Color(0xff24C3A1)
                            : Color(0xffC4C4C4).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(2)),
                    child: Center(
                      child: Text(
                        "1 sao" + "(11)",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      rating: 5.0,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        "Sản phẩm đúng mô tả",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffC4C4C4).withOpacity(0.5),
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffC4C4C4).withOpacity(0.7),
                                    width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  "https://media-exp3.licdn.com/dms/image/C4D1BAQH_-MPoR3IxIw/company-background_10000/0/1607441172662?e=2159024400&v=beta&t=9ptL2qcgRmHp-B6NM15vDrAPIv7jGqNirRRCCKc-0lc",
                                  height: 40,
                                  width: 30,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Đầm bầu phối hoa viền ren nữ tính 115 SID61193",
                                        style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          "Phân loại: " + "Hồng, Freesize",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "01-04-2021 13:00",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 10,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
