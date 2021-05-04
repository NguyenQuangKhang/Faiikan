import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/models/category.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:faiikan/models/category.dart' as Cate;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final items = [
  "https://www.designbold.com/academy/wp-content/uploads/2018/08/Tutorial_40.jpg",
  "https://i.ytimg.com/vi/U8HU_IuoGJ0/maxresdefault.jpg",
  "https://designjiaoshi.com/wp-content/uploads/2019/09/6cbaf17f476f12e-4.jpg",
  "https://image.freepik.com/free-vector/modern-fashion-sale-poster-collection_1361-1199.jpg",
];

class ForYouScreen extends StatefulWidget {
  @override
  _ForYouScreenState createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  int _current = 0;
  int time = 23 * 3600;
  late Timer _timer;
  CarouselController carouselController = CarouselController();
  late ProductBloc productBloc;
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  bool flag = true;

  @override
  void initState() {

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) time--;
      });
    });

    super.initState();
    productBloc = context.read<ProductBloc>();
//    context.bloc<RecommendProductBloc>()
//      ..add(RecommendProductLoadEvent(
//          userId: context.bloc<LoginBloc>().user?.id ?? 0));
    print("Reload");
    _scrollController2.addListener(() {
      if (_scrollController2.position.pixels ==
          _scrollController2.position.maxScrollExtent)
        setState(() {
          flag = false;
        });
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        setState(() {
          flag = true;
          print(flag);
        });
      }
//
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(ProductGetMoreDataEvent(SortBy: 0));
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color(0xffE7E7E7),
      child: SingleChildScrollView(
        controller: _scrollController2,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: items.map((e) {
                    return CachedNetworkImage(
                      imageUrl: e,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                  }).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    pauseAutoPlayOnTouch: true,
                    height: MediaQuery.of(context).size.height / 3 - 50,
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(items.length, (index) {
                        return GestureDetector(
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                horizontal: 3, vertical: 5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Colors.black
                                    : Colors.black26),
                          ),
                          onTap: () {
                            setState(() {
                              _current = index;
                              carouselController.animateToPage(index);
                            });
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/flashsale.png"),
                              Text(
                                "FLASH SALE",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xffF34646),
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
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
                                          : "0" +
                                              (time % 3600 ~/ 60).toString(),
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
                    Container(
                      height: MediaQuery.of(context).size.height / 4 - 40,
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 2000),
                                    pageBuilder: (context, animation, _) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: ProductDetail(
                                          productId: 1,
                                        ),
                                      );
                                    }));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 20,
                                ),
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 2),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://assets.adidas.com/images/w_600,f_auto,q_auto/e714edee57fa45a2b102acaf010e276d_9366/Stan_Smith_Shoes_White_GZ3098_01_standard.jpg",
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.purple
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0,
                                                      0), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            child: Container(
                                              height: 20,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffF05A5A),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5))),
                                              child: Center(
                                                child: Text(
                                                  "50%",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "162.000đ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              center: Text(
                                                "10 đã bán",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2, horizontal: 5),
                                              percent: 0.6,
                                              lineHeight: 18,
                                              backgroundColor:
                                                  Color(0xffF9AEAE),
                                              progressColor: Color(0xffFF6161),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "DANH MỤC",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text(
                            "Xem tất cả",
                            style: TextStyle(
                              color: Color(0xff3A1DEC),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Color(0xff3A1DEC),
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (_) => BlocProvider.value(
//                                  value: context.bloc<CategoryBloc>(),
//                                  child: ExploreScreenNew())));
                    },
                  )
                ],
              ),
            ),
            Container(
                height: 10,
                width: MediaQuery.of(context).size.width,
                color: Colors.white),
            Row(
              children: <Widget>[
                Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            context.read<CategoryBloc>().list_cat_1.length,
                        itemBuilder: (context, index) {
                          Cate.Category category =
                              context.read<CategoryBloc>().list_cat_1[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: GestureDetector(
                                child: Container(
                                  width: 70,
                                  height: 100,
                                  margin: index != 0
                                      ? EdgeInsets.only(
                                          top: 5, bottom: 5, left: 10)
                                      : EdgeInsets.only(top: 5, bottom: 5),
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.blue.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: CachedNetworkImage(
                                            imageUrl: category.icon != null
                                                ? category.icon
                                                : "https://i.pinimg.com/236x/30/87/8d/30878dc76c22265aa23b6c0328886113.jpg",
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.fill,
                                            width: 25,
                                            height: 25,
                                            colorBlendMode: BlendMode.colorBurn,
                                          ),
                                        )),
                                      ),
                                      Container(
                                        height: 40,
                                        child: Center(
                                          child: Text(
                                            category.name,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {}),
                          );
                        })),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TÌM KIẾM PHỔ BIẾN",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            color: Color(0xff0C73D2),
                            size: 25,
                          ),
                          Text(
                            "Đổi",
                            style: TextStyle(
                              color: Color(0xff0C73D2),
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2,
                      crossAxisCount: 2,
                      children: List.generate(4, (index) {
                        return Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black12,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height /
                                                    4 -
                                                20) /
                                            2,
                                    child: Center(
                                      child: Text(
                                        "Giày nữ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height:
                                      (MediaQuery.of(context).size.height / 4 -
                                              20) /
                                          2,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://vn-test-11.slatic.net/p/280ad8c7923b4f8630034bf2c78d08af.jpg_320x320.jpg",
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.filter_list,
                            size: 30,
                            color: Color(0xff222222),
                          ),
                          Text(
                            "Lọc",
                            style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 14,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            color: Color(0xff222222),
                            size: 30,
                          ),
                          Text(
                            "Phổ biến",
                            style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 14,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  BlocBuilder<ProductBloc, ProductsState>(
                    builder: (context, state) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            //margin: EdgeInsets.only(left: 5),
                            color: Colors.white,

                            height: MediaQuery.of(context).size.height/2,
                            child: CustomScrollView(
                                shrinkWrap: true,
                                primary: false,
                                physics: flag == true
                                    ? NeverScrollableScrollPhysics()
                                    : ClampingScrollPhysics(),
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                slivers: <Widget>[
                                  SliverGrid(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              40) /
                                          (MediaQuery.of(context).size.height /
                                                  3 +
                                              15),
                                      mainAxisSpacing: 0.0,
                                      crossAxisSpacing: 0.0,
                                      //childAspectRatio: AppSizes.tile_width / AppSizes.tile_height,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 8, right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),

                                          //padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                          child: GestureDetector(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        3 +
                                                    20,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  backgroundBlendMode:
                                                      BlendMode.colorBurn,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                      offset: Offset(0,
                                                          0), // changes position of shadow
                                                    ),
                                                  ],
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black.withOpacity(0.5),
//                                                 spreadRadius: 5,
//                                                 blurRadius: 7,
//                                                 offset: Offset(0, 3),
//
//
//                                               ),
//                                             ],
                                                ),
                                                child: ProductCard(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  product: productBloc.listdata[index],
                                                  index: index,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider<
                                                                    ProductDetailBloc>(
                                                                create:
                                                                    (context) {
                                                                  return ProductDetailBloc(
                                                                      InitialProductDetail())
                                                                    ..add(
                                                                        ProductDetailLoadEvent(
                                                                      id: productBloc
                                                                          .listdata[
                                                                              index]
                                                                          .id,
                                                                      person_id:
                                                                          '',
                                                                    ));
                                                                },
                                                                child:
                                                                    ProductDetail(
                                                                  productId: productBloc
                                                                      .listdata[
                                                                          index]
                                                                      .id,
                                                                ))));
                                              }),
                                        );
                                      },
                                      childCount: productBloc.listdata.length,
                                    ),
                                  ),
                                ]),
                          ),
                          if (state is Loading)
                            Positioned(
                              bottom: 10,
                              left: MediaQuery.of(context).size.width / 2 - 15,
                              child: Container(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
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
