import 'package:auto_size_text/auto_size_text.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/screens/register_login_screen/login_screen.dart';
import 'package:faiikan/screens/register_login_screen/register_and_login_screen.dart';
import 'package:faiikan/screens/register_login_screen/register_screen.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE7E7E7),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2 - 60,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3 + 30,
                    decoration: BoxDecoration(
                      color: Color(0xffF34646),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10,
                                top: 30,
                              ),
                              child: Icon(
                                CustomIcon.setting,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5), //10
                                height: 80, //140
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4, //8
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg"),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterAndLoginScreen(
                                              initialIndex: 1,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Đăng nhập",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                  Text(
                                    " / ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterAndLoginScreen(
                                                  initialIndex: 0,
                                                )),
                                      );
                                    },
                                    child: Text(
                                      "Đăng ký",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 + 200,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text(
                                            "0",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Voucher",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "0",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Điểm",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 3 - 70,
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 10,
                        left: 10,
                      ),
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Đơn mua",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.normal),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Xem lịch sử mua hàng",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Color(0xff666666),
                                      size: 10,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 15,
                                left: 10,
                                right: 10,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/choxacnhan.png",
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          width:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AutoSizeText(
                                          "Chờ xác nhận",
                                          maxLines: 1,
                                          minFontSize: 12,
                                          maxFontSize: 20,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black.withOpacity(0.7),
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/cholayhang.png",
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          width:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AutoSizeText(
                                          "Chờ lấy hàng",
                                          maxLines: 1,
                                          minFontSize: 12,
                                          maxFontSize: 20,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black.withOpacity(0.7),
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/danggiao.png",
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          width:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AutoSizeText(
                                          "Đang giao",
                                          minFontSize: 12,
                                          maxLines: 1,
                                          maxFontSize: 20,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black.withOpacity(0.7),
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/dagiao.png",
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          width:
                                              MediaQuery.of(context).size.height /
                                                  20,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AutoSizeText(
                                          "Đã giao",
                                          minFontSize: 12,
                                          maxFontSize: 20,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black.withOpacity(0.7),
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.recently_seen,
                        color: Color(0xff2284CA),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Đã xem gần đây",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xff666666),
                        size: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.my_review,
                        color: Color(0xff1A7A24),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Đánh giá của tôi",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xff666666),
                        size: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.account,
                        color: Color(0xff2E53B1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Thiết lập tài khoản",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xff666666),
                        size: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.help,
                        color: Color(0xffC23E2C),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Trung tâm trợ giúp",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xff666666),
                        size: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "CÓ THỂ BẠN THÍCH",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 16,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 4 +20,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ProductCard(
                            width: MediaQuery.of(context).size.width / 2 ,
                            height: MediaQuery.of(context).size.height / 4,
                            product: new Product(name: "Áo abcxyz",price: 200000,adminId: 1,categoryId: "1",countRating: 4,finalPrice: 150000,freeShipping: true,imgUrl: "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",isEvent: true,isPromotion: true,orderCount: 23,percentStar: 3.2,productId: 1,promotionPercent: 20,shopId: 1,shopName: "ádsa",shopWarehouseCity: "ádd" ),
                            index: index,
                          ),
                        );
                      },
                      itemCount: 5,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
