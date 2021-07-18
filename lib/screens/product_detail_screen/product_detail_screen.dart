import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/RatingBloc/rating_bloc.dart';
import 'package:faiikan/blocs/RatingBloc/rating_event.dart';
import 'package:faiikan/blocs/RatingBloc/rating_state.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteBloc.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_bloc.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_event.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_state.dart';
import 'package:faiikan/models/cart_item.dart' as CartItem;
import 'package:faiikan/models/product.dart';
import 'package:faiikan/screens/cart_screen/cart_screen.dart';
import 'package:faiikan/screens/main_screen/home_tab.dart';
import 'package:faiikan/screens/main_screen/home_tab_tab/for_you_tab.dart';
import 'package:faiikan/screens/payment_screen/payment_screen.dart';
import 'package:faiikan/screens/review_screen/review_screen.dart';
import 'package:faiikan/screens/similar_product_screen/similar_product_screen.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/attribute_sheet.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:faiikan/widgets/product_property_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetail extends StatefulWidget {
  final int productId;
  final Price price;
  final double percentStar;
  final int countRating;
  final int userId;
  bool isNavigatedFromFavorite;
  bool isInFavorite;

  ProductDetail({
    required this.productId,
    required this.price,
    required this.percentStar,
    required this.countRating,
    required this.userId,
    this.isNavigatedFromFavorite = false,
    this.isInFavorite = false,
  });

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  int _current = 0;
  int? countCart;
  bool isExpanded = false;
  int selectedIndex = 1;
  late AnimationController animationController;
  late Animation<double> animation;
  bool isAnimating = false;
  late List<String> images;
  double elevation = 0;
  bool start = false;
  late Timer _timer;
  int time = 23 * 3600;
  late ProductDetailBloc productDetailBloc;
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween,
      _homeTween,
      _workOutTween,
      _iconTween,
      _drawerTween;
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
        context.read<ProductDetailBloc>().add(
            LoadMoreProductAlsoLikeEvent(person_id: context
                .read<AccountBloc>()
                .userId == 0 ? "0" : widget.userId.toString()));
      }
    });
    //AppBar

    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_ColorAnimationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_ColorAnimationController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(_ColorAnimationController);
    _workOutTween = ColorTween(
        begin: Colors.black.withOpacity(0.5),
        end: Colors.black.withOpacity(0.1))
        .animate(_ColorAnimationController);
    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    // AppBar //

    animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() {
        if (animation.status == AnimationStatus.completed) {
          if (countCart == null) {
            countCart = countCart;
          } else {
            setState(() {
              countCart = countCart! + 1;
            });
          }
          setState(() {
            isAnimating = false;
          });
        }
      });
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    productDetailBloc = context.read<ProductDetailBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isInFavorite ? BlocListener(
        bloc: context.read<ProductDetailBloc>(),
        listener: (context1, state) {
          if (state is FavoriteTapSuccess) {
            print("asdasdasdasd");
            if (context
                .read<AccountBloc>()
                .userId != 0)
              context.read<FavoriteBloc>().add(
                  FavoriteLoadEvent(person_id: widget.userId.toString()));
          }

        },
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is LoadingProductDetail ||
                state is InitialProductDetail ||
                state is LoadingProductDetailReset)
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.withOpacity(0.5),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.35,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor:
                                      Colors.grey.withOpacity(0.5),
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            "loading..................",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color(0xffF65151),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor:
                                      Colors.grey.withOpacity(0.5),
                                      child: Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 20,
                                          child: Center(
                                              child: Text(
                                                "loading...",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                    decoration:
                                                    TextDecoration.lineThrough,
                                                    decorationThickness: 2,
                                                    decorationColor: Colors
                                                        .black54,
                                                    decorationStyle:
                                                    TextDecorationStyle.solid),
                                              ))),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: Container(
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration:
                                      BoxDecoration(color: Color(0xffF9CF3B)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              "..." + "%",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffF65151)),
                                            ),
                                            Text(
                                              "...",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
//                        SizedBox(
//                          height: 10,
//                        ),
                          Row(
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 30,
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    child: Text(
                                      "loading.....loading.......loading......",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    )),
                              ),
                            ],
                          ),

                          Row(
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: SizedBox(
                                  height: 20,
                                  child: RatingBarIndicator(
                                    rating: 0,
                                    itemBuilder: (context, index) =>
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: Container(
                                  height: 15,
                                  alignment: Alignment.center,
                                  child: Text(
                                    ".......",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 20,
                                width: 2,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Đã bán " + ".........",
                                style:
                                TextStyle(color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Color(0xffE7E7E7),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Chọn loại hàng (màu sắc, kích thước ,...)",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 90,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  if (index == 3)
                                    return InkWell(
                                      onTap: () async {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffC4C4C4)
                                                .withOpacity(0.3),
                                            border: Border.all(
                                              color: Colors.black26,
                                              width: 1,
                                            )),
                                        height: 70,
                                        width: 55,
                                        child: Center(
                                          child: Icon(
                                            Icons.more_horiz_outlined,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.grey.withOpacity(
                                        0.5),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: 5,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black26,
                                            width: 1,
                                          )),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 55,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xffE7E7E7),
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CustomIcon.tick,
                                color: Color(0xffF65151),
                                size: 12,
                              ),
                              Text(
                                "Miễn phí trả hàng",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CustomIcon.tick,
                                color: Color(0xffF65151),
                                size: 12,
                              ),
                              Text(
                                "Giao miễn phí",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CustomIcon.tick,
                                color: Color(0xffF65151),
                                size: 12,
                              ),
                              Text(
                                "Chất lượng đảm bảo",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xffE7E7E7),
                      height: 10,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Mô tả",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black26,
                      height: 1,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "loading...........loading..... \n loading...........loading..... \n loading...........loading..... \n ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    "<Xem thêm>",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () async {},
//
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffE7E7E7),
                      height: 10,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Chi tiết sản phẩm ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black26,
                      height: 1,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ProductPropertyDetail(
                              firstText: "THƯƠNG HIỆU",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "CHẤT LIỆU",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "MỤC ĐÍCH SD",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "MÙA PHÙ HỢP",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "NƠI SX",
                              secondText: "loading............",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            else {
              images = productDetailBloc.productDetail.attributes
                  .firstWhere((element) => element.code == "image")
                  .options
                  .map((e) => e.value)
                  .toList();
              return Container(
                color: Colors.white,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.axis == Axis.vertical) {
                                _ColorAnimationController.animateTo(scrollInfo
                                    .metrics.pixels /
                                    (MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.35 -
                                        80));
                                if (scrollInfo.metrics.pixels >=
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.35 -
                                        100 &&
                                    elevation == 0) {
                                  elevation = 1;
                                }
                                if (scrollInfo.metrics.pixels <
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.35 -
                                        100) {
                                  elevation = 0;
                                }
                                return true;
                              }
                              return true;
                            },
                            child: RefreshIndicator(
                              color: Colors.redAccent,
                              onRefresh: () async {
                                await Future.delayed(
                                  Duration(seconds: 2),
                                );
                                productDetailBloc.add(ProductDetailResetEvent(
                                    id: productDetailBloc.productDetail.id,
                                    person_id: context
                                        .read<AccountBloc>()
                                        .userId == 0 ? "0" : widget.userId
                                        .toString()));
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                controller: _scrollController2,
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        CarouselSlider(
                                          items: List.generate(images.length,
                                                  (index) {
                                                return CachedNetworkImage(
                                                  imageUrl: images[index],
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width -
                                                      200,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                      Icon(Icons.error),
                                                );
                                              }),
                                          options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            },
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.35,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 15,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 8),
                                            decoration: BoxDecoration(
                                                color:
                                                Colors.black.withOpacity(0.5),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                (_current + 1).toString() +
                                                    "/" +
                                                    images.length.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
//
                                                    fontSize: 10,
                                                    fontWeight: FontWeight
                                                        .w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration:
                                      BoxDecoration(color: Color(0xffffffff)),
                                      padding: EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                      Alignment.topCenter,
                                                      height: 30,
                                                      child: Center(
                                                        child: Text(
                                                          NumberFormat
                                                              .simpleCurrency(
                                                              locale:
                                                              "vi")
                                                              .format(widget
                                                              .price.priceMin)
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 20,
                                                            color:
                                                            Color(0xffF65151),
                                                          ),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    productDetailBloc
                                                        .productDetail
                                                        .promotion
                                                        ? Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        height: 20,
                                                        child: Center(
                                                            child: Text(
                                                              NumberFormat
                                                                  .simpleCurrency(
                                                                  locale:
                                                                  "vi")
                                                                  .format(
                                                                  (widget
                                                                      .price
                                                                      .priceMin *
                                                                      (1 +
                                                                          (productDetailBloc
                                                                              .productDetail
                                                                              .promotionPercent /
                                                                              100)))),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  decorationThickness:
                                                                  2,
                                                                  decorationColor:
                                                                  Colors
                                                                      .black54,
                                                                  decorationStyle:
                                                                  TextDecorationStyle
                                                                      .solid),
                                                            )))
                                                        : Container(),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              productDetailBloc
                                                  .productDetail.promotion
                                                  ? Container(
                                                child: Center(
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    BoxDecoration(
                                                        color: Color(
                                                            0xffF9CF3B)),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            productDetailBloc
                                                                .productDetail
                                                                .promotionPercent
                                                                .toString() +
                                                                "%",
                                                            style: TextStyle(
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Color(
                                                                    0xffF65151)),
                                                          ),
                                                          Text(
                                                            "GIẢM",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                letterSpacing:
                                                                0.5),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : Container(),
                                            ],
                                          ),
//                        SizedBox(
//                          height: 10,
//                        ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width -
                                                      30,
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  height: 50,
                                                  child: Text(
                                                    productDetailBloc
                                                        .productDetail.name,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w400,
                                                      fontSize: 16,
                                                      letterSpacing: 0.5,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  )),
                                            ],
                                          ),

                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                                child: RatingBarIndicator(
                                                  rating: calAverageStarRating(
                                                      context
                                                          .read<
                                                          ProductDetailBloc>()
                                                          .productDetail
                                                          .ratingStar),
                                                  itemBuilder: (context,
                                                      index) =>
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                  itemCount: 5,
                                                  itemSize: 20.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 15,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  widget.percentStar.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 20,
                                                width: 2,
                                                color: Colors.black54,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Đã bán " +
                                                    productDetailBloc
                                                        .productDetail
                                                        .orderCount
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 10,
                                      color: Color(0xffE7E7E7),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "Chọn loại hàng (màu sắc, kích thước ,...)",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          BlocListener(
                                            bloc: context.read<
                                                ProductDetailBloc>(),
                                            listener: (context, state) {
                                              if (state is AddtoCartSuccess) {
                                                context
                                                    .read<CartBloc>()
                                                    .add(GetCartEvent(
                                                    person_id: widget
                                                        .userId
                                                        .toString()));
                                                setState(() {
                                                  isAnimating = true;
                                                });
                                                animationController
                                                    .reset();
                                                animationController
                                                    .forward();
                                              }
                                            },
                                            child: Container(
                                              height: 90,
                                              child: ListView.builder(
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  padding: EdgeInsets.all(10),
                                                  itemCount: images.length + 1,
                                                  itemBuilder: (context,
                                                      index) {
                                                    if (index == images.length)
                                                      return InkWell(
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                              context: context,
                                                              builder: (_) {
                                                                return BlocProvider
                                                                    .value(
                                                                  value: context
                                                                      .read<
                                                                      ProductDetailBloc>(),
                                                                  child:
                                                                  AttributesSheet(
                                                                    images: images,
                                                                    hasMuaHang: true,
                                                                    hasThemGioHang: true,
                                                                  ),
                                                                );
                                                              }).then((value) {
                                                            if (value ==
                                                                "Thêm vào giỏ hàng" &&
                                                                context
                                                                    .read<
                                                                    AccountBloc>()
                                                                    .userId !=
                                                                    0) {
                                                              productDetailBloc
                                                                  .add(
                                                                  AddtocartEvent(
                                                                      person_id: context
                                                                          .read<
                                                                          AccountBloc>()
                                                                          .userId ==
                                                                          0
                                                                          ? "0"
                                                                          : widget
                                                                          .userId
                                                                          .toString(),
                                                                      product_id:
                                                                      productDetailBloc
                                                                          .productDetail
                                                                          .id
                                                                          .toString(),
                                                                      option_amount_id:
                                                                      productDetailBloc
                                                                          .optionProductId,
                                                                      amount:
                                                                      productDetailBloc
                                                                          .amount));

//
                                                            }
                                                            if (value ==
                                                                "Mua ngay" &&
                                                                context
                                                                    .read<
                                                                    AccountBloc>()
                                                                    .userId !=
                                                                    0) {
                                                              var optionProduct = productDetailBloc
                                                                  .productDetail
                                                                  .optionProducts
                                                                  .firstWhere((
                                                                  element) =>
                                                              element
                                                                  .productOptionId
                                                                  .toString() ==
                                                                  productDetailBloc
                                                                      .optionProductId);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          _) =>
                                                                          BlocProvider
                                                                              .value(
                                                                            value: context
                                                                                .read<
                                                                                CartBloc>(),
                                                                            child: BlocProvider(
                                                                              create: (
                                                                                  _) =>
                                                                              AddressBloc(
                                                                                  LoadAddress())
                                                                                ..add(
                                                                                    InitialAddressEvent(
                                                                                        userId: widget
                                                                                            .userId
                                                                                            .toString())),
                                                                              child: BlocProvider
                                                                                  .value(
                                                                                value: context
                                                                                    .read<
                                                                                    AccountBloc>(),
                                                                                child: BlocProvider
                                                                                    .value(
                                                                                  value: context
                                                                                      .read<
                                                                                      ProductBloc>(),
                                                                                  child: PaymentScreen(
                                                                                    userId: widget
                                                                                        .userId
                                                                                        .toString(),
                                                                                    listItems: [
                                                                                      CartItem
                                                                                          .CartItem(
                                                                                          cartId: 0,
                                                                                          productId: productDetailBloc
                                                                                              .productDetail
                                                                                              .id,
                                                                                          nameProduct: productDetailBloc
                                                                                              .productDetail
                                                                                              .name,
                                                                                          amount: productDetailBloc
                                                                                              .amount,
                                                                                          optionProduct: CartItem
                                                                                              .OptionProduct(
                                                                                              productOptionId: optionProduct
                                                                                                  .productOptionId,
                                                                                              price: CartItem
                                                                                                  .Price(
                                                                                                  value: optionProduct
                                                                                                      .price
                                                                                                      .value,
                                                                                                  id: optionProduct
                                                                                                      .price
                                                                                                      .id),
                                                                                              quantity: CartItem
                                                                                                  .Quantity(
                                                                                                  value: optionProduct
                                                                                                      .quantity
                                                                                                      .value,
                                                                                                  id: optionProduct
                                                                                                      .quantity
                                                                                                      .id),
                                                                                              color: CartItem
                                                                                                  .Color(
                                                                                                  value: productDetailBloc
                                                                                                      .options
                                                                                                      .length >
                                                                                                      1
                                                                                                      ? productDetailBloc
                                                                                                      .options[1]
                                                                                                      : "",
                                                                                                  id: 0),
                                                                                              size: CartItem
                                                                                                  .Size(
                                                                                                  id: 0,
                                                                                                  value: productDetailBloc
                                                                                                      .options[0]),
                                                                                              image: CartItem
                                                                                                  .Image(
                                                                                                  value: images[0],
                                                                                                  id: 0)))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )));
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffC4C4C4)
                                                                  .withOpacity(
                                                                  0.3),
                                                              border: Border
                                                                  .all(
                                                                color:
                                                                Colors.black26,
                                                                width: 1,
                                                              )),
                                                          height: 70,
                                                          width: 55,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .more_horiz_outlined,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        right: 5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .black26,
                                                            width: 1,
                                                          )),
                                                      child: Stack(
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl: productDetailBloc
                                                                .productDetail
                                                                .attributes
                                                                .firstWhere(
                                                                    (element) =>
                                                                element
                                                                    .code ==
                                                                    "image")
                                                                .options
                                                                .map((e) =>
                                                            e.value)
                                                                .toList()[index],
                                                            height: 70,
                                                            width: 55,
                                                            fit: BoxFit.fill,
                                                            placeholder: (
                                                                context,
                                                                url) =>
                                                                Center(
                                                                    child:
                                                                    CircularProgressIndicator()),
                                                            errorWidget: (
                                                                context,
                                                                url, error) =>
                                                                Icon(Icons
                                                                    .error),
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
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CustomIcon.tick,
                                                color: Color(0xffF65151),
                                                size: 12,
                                              ),
                                              Text(
                                                "Miễn phí trả hàng",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CustomIcon.tick,
                                                color: Color(0xffF65151),
                                                size: 12,
                                              ),
                                              Text(
                                                "Giao miễn phí",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CustomIcon.tick,
                                                color: Color(0xffF65151),
                                                size: 12,
                                              ),
                                              Text(
                                                "Chất lượng đảm bảo",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        "Mô tả",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            productDetailBloc
                                                .productDetail.shortDescription,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Text(
                                                  "<Xem thêm>",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) {
                                                        return Stack(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 40,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  SingleChildScrollView(
                                                                    scrollDirection:
                                                                    Axis
                                                                        .vertical,
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                        10),
                                                                    child:
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .only(
                                                                              topLeft:
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                              topRight: Radius
                                                                                  .circular(
                                                                                  10))),
                                                                      padding: EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                          10),
                                                                      child: Html(
                                                                        data: productDetailBloc
                                                                            .productDetail
                                                                            .description,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Positioned(
                                                                top: 5,
                                                                right: 5,
                                                                child: Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color:
                                                                  Colors.grey,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
//
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        "Chi tiết sản phẩm ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          if(productDetailBloc
                                              .productDetail.brand !=
                                              null) ProductPropertyDetail(
                                            firstText: "THƯƠNG HIỆU",
                                            secondText: productDetailBloc
                                                .productDetail.brand!.name!,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "CHẤT LIỆU",
                                            secondText: productDetailBloc
                                                .productDetail.material,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "MỤC ĐÍCH SD",
                                            secondText: productDetailBloc
                                                .productDetail.purpose,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "MÙA PHÙ HỢP",
                                            secondText: productDetailBloc
                                                .productDetail.suitableSeason,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "NƠI SX",
                                            secondText: productDetailBloc
                                                .productDetail.madeIn,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Đánh giá",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                    Column(
                                      children: List.generate(
                                          productDetailBloc.productDetail
                                              .ratings
                                              .listrating.length, (index) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        children: [
//                                                CircleAvatar(
//                                                  backgroundImage: NetworkImage(
//                                                      productDetailBloc.productDetail.ratings.listrating[index].imageAvatar),
//                                                  radius: 15,
//                                                ),
                                                          Container(
//                                                  margin: EdgeInsets.only(bottom: 5), //10
                                                            height: 35, //140
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                              shape:
                                                              BoxShape.circle,
//                                                    border: Border.all(
//                                                      color: Colors.white,
//                                                      width: 2, //8
//                                                    ),
                                                              image:
                                                              DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image:
                                                                  NetworkImage(
                                                                    productDetailBloc
                                                                        .productDetail
                                                                        .ratings
                                                                        .listrating[
                                                                    index]
                                                                        .imageAvatar,
                                                                  )),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .blue
                                                                      .withOpacity(
                                                                      0.5),
                                                                  spreadRadius: 1,
                                                                  blurRadius: 1,
                                                                  offset: Offset(
                                                                      0,
                                                                      0), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            productDetailBloc
                                                                .productDetail
                                                                .ratings
                                                                .listrating[index]
                                                                .userName,
                                                            style: TextStyle(
                                                                color:
                                                                Colors.black,
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                0.5,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                        child: RatingBarIndicator(
                                                          rating:
                                                          productDetailBloc
                                                              .productDetail
                                                              .ratings
                                                              .listrating[
                                                          index]
                                                              .star
                                                              .toDouble(),
                                                          itemBuilder:
                                                              (context,
                                                              index) =>
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                          itemCount: 5,
                                                          itemSize: 20.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 35,
                                                      ),
                                                      Text(productDetailBloc
                                                          .productDetail
                                                          .ratings
                                                          .listrating[index]
                                                          .comment),
                                                    ],
                                                  ),
                                                  if (productDetailBloc
                                                      .productDetail
                                                      .ratings
                                                      .listrating[index]
                                                      .imageRating
                                                      .length >
                                                      0)
                                                    Container(
                                                        margin:
                                                        EdgeInsets.fromLTRB(
                                                            15, 15, 0, 15),
                                                        height: 100,
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                            Axis.horizontal,
                                                            itemCount:
                                                            productDetailBloc
                                                                .productDetail
                                                                .ratings
                                                                .listrating[
                                                            index]
                                                                .imageRating
                                                                .length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              String image =
                                                              productDetailBloc
                                                                  .productDetail
                                                                  .ratings
                                                                  .listrating[
                                                              index]
                                                                  .imageRating[i];
                                                              return Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                      border: Border
                                                                          .all(
                                                                        width:
                                                                        1,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                            0.2),
                                                                      ),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors
                                                                                .black26,
                                                                            blurRadius:
                                                                            1,
                                                                            spreadRadius:
                                                                            1,
                                                                            offset: Offset(
                                                                                0,
                                                                                0))
                                                                      ]),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      15),
                                                                  child:
                                                                  CachedNetworkImage(
                                                                    imageUrl:
                                                                    image,
                                                                    placeholder: (
                                                                        context,
                                                                        url) =>
                                                                        Center(
                                                                            child:
                                                                            CircularProgressIndicator()),
                                                                    errorWidget: (
                                                                        context,
                                                                        url,
                                                                        error) =>
                                                                        Icon(
                                                                            Icons
                                                                                .error),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .width /
                                                                        4,
                                                                    height: 100,
                                                                    colorBlendMode:
                                                                    BlendMode
                                                                        .darken,
                                                                  ));
                                                            })),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              color: Colors.black26,
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (_) =>
                                                          BlocProvider.value(
                                                            value:
                                                            productDetailBloc,
                                                            child: BlocProvider(
                                                                create: (
                                                                    BuildContext context) =>
                                                                RatingBloc(
                                                                    InitialRatingState())
                                                                  ..add(
                                                                      InitiateRatingEvent(
                                                                          product_id: widget
                                                                              .productId
                                                                              .toString())),
                                                                child:
                                                                ReviewScreen()),
                                                          )));
                                            },
                                            child: Center(
                                              child: Text(
                                                "<Xem tất cả>",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    /// sản phẩm tương tự
//                                  Row(
//                                    children: [
//                                      Container(
//                                        width: MediaQuery.of(context).size.width,
//                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                                        color: Colors.white,
//                                        child: Text(
//                                          "Sản phẩm tương tự",
//                                          style: TextStyle(
//                                            color: Colors.black87,
//                                            fontSize: 18,
//                                            letterSpacing: 0.5,
//                                            fontWeight: FontWeight.w500,
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  if(state is LoadingRecommendAndAlsoLikeProduct)
//                                    Shimmer.fromColors(
//                                      baseColor: Colors.grey,
//                                      highlightColor: Colors.grey.withOpacity(0.5),
//                                        child: Container(
//                                          height: MediaQuery.of(context).size.height /
//                                              4 <
//                                              200
//                                              ? 200
//                                              : MediaQuery.of(context).size.height /
//                                              4,
//                                          width: MediaQuery.of(context).size.width,
//                                          child: ListView.builder(
//                                              scrollDirection: Axis.horizontal,
//                                              itemCount: 11,
//                                              itemBuilder: (context, index) {
//                                                if (index == 10)
//                                                  return InkWell(
//                                                    onTap: (){
//
//                                                    },
//                                                    child: Container(
//                                                        height: MediaQuery.of(context)
//                                                            .size
//                                                            .height /
//                                                            4 <
//                                                            200
//                                                            ? 200
//                                                            : MediaQuery.of(context)
//                                                            .size
//                                                            .height /
//                                                            4,
//                                                        width: MediaQuery.of(context)
//                                                            .size
//                                                            .width /
//                                                            3,
//                                                        margin:
//                                                        EdgeInsets.only(right: 5),
//                                                        child: Center(
//                                                          child: Container(
//                                                              height: 60,
//                                                              child: Column(
//                                                                children: [
//                                                                  Container(
//                                                                      height: 30,
//                                                                      width: 30,
//                                                                      decoration: BoxDecoration(
//                                                                          border: Border.all(
//                                                                              width: 1,
//                                                                              color: Colors
//                                                                                  .redAccent)),
//                                                                      child: Center(
//                                                                          child: Icon(
//                                                                            Icons
//                                                                                .arrow_forward_ios_rounded,
//                                                                            size: 10,
//                                                                          ))),
//                                                                  SizedBox(
//                                                                    height: 10,
//                                                                  ),
//                                                                  Text(
//                                                                    "Xem thêm",
//                                                                    style: TextStyle(
//                                                                        fontSize: 14,
//                                                                        letterSpacing:
//                                                                        0.5,
//                                                                        color: Colors
//                                                                            .redAccent),
//                                                                  )
//                                                                ],
//                                                              )),
//                                                        )),
//                                                  );
//                                                return Container(
//                                                  margin:
//                                                  EdgeInsets.only(right: 5),
//                                                  child: Container(
//
//                                                    height: MediaQuery.of(context)
//                                                        .size
//                                                        .height /
//                                                        4 <
//                                                        200
//                                                        ? 200
//                                                        : MediaQuery.of(context)
//                                                        .size
//                                                        .height /
//                                                        4,
//                                                    width: MediaQuery.of(context)
//                                                        .size
//                                                        .width /
//                                                        3,
//                                                  ),
//                                                );
//                                              }),
//                                        ),
//                                    )
//                                    else
//                                  Container(
//                                    height: MediaQuery.of(context).size.height /
//                                                4 <
//                                            200
//                                        ? 200
//                                        : MediaQuery.of(context).size.height /
//                                            4,
//                                    width: MediaQuery.of(context).size.width,
//                                    child: ListView.builder(
//                                        scrollDirection: Axis.horizontal,
//                                        itemCount: 11,
//                                        itemBuilder: (context, index) {
//                                          if (index == 10)
//                                            return InkWell(
//                                              onTap: (){
//
//                                              },
//                                              child: Container(
//                                                  height: MediaQuery.of(context)
//                                                                  .size
//                                                                  .height /
//                                                              4 <
//                                                          200
//                                                      ? 200
//                                                      : MediaQuery.of(context)
//                                                              .size
//                                                              .height /
//                                                          4,
//                                                  width: MediaQuery.of(context)
//                                                          .size
//                                                          .width /
//                                                      3,
//                                                  margin:
//                                                      EdgeInsets.only(right: 5),
//                                                  child: Center(
//                                                    child: Container(
//                                                        height: 60,
//                                                        child: Column(
//                                                          children: [
//                                                            Container(
//                                                                height: 30,
//                                                                width: 30,
//                                                                decoration: BoxDecoration(
//                                                                    border: Border.all(
//                                                                        width: 1,
//                                                                        color: Colors
//                                                                            .redAccent)),
//                                                                child: Center(
//                                                                    child: Icon(
//                                                                  Icons
//                                                                      .arrow_forward_ios_rounded,
//                                                                  size: 10,
//                                                                ))),
//                                                            SizedBox(
//                                                              height: 10,
//                                                            ),
//                                                            Text(
//                                                              "Xem thêm",
//                                                              style: TextStyle(
//                                                                  fontSize: 14,
//                                                                  letterSpacing:
//                                                                      0.5,
//                                                                  color: Colors
//                                                                      .redAccent),
//                                                            )
//                                                          ],
//                                                        )),
//                                                  )),
//                                            );
//                                          return GestureDetector(
//                                              child: Container(
//                                                margin:
//                                                    EdgeInsets.only(right: 5),
//                                                child: ProductCard(
//                                                  onTapFavorite: () {},
//                                                  height: MediaQuery.of(context)
//                                                                  .size
//                                                                  .height /
//                                                              4 <
//                                                          200
//                                                      ? 200
//                                                      : MediaQuery.of(context)
//                                                              .size
//                                                              .height /
//                                                          4,
//                                                  width: MediaQuery.of(context)
//                                                          .size
//                                                          .width /
//                                                      3,
//                                                  product: productDetailBloc
//                                                          .listSimilarProduct[
//                                                      index],
//                                                  index: index,
//                                                ),
//                                              ),
//                                              onTap: () {
//                                                Navigator.push(
//                                                    context,
//                                                    MaterialPageRoute(
//                                                        builder: (_) =>
//                                                            MultiBlocProvider(
//                                                                providers: [
//                                                                  BlocProvider(
//                                                                      create: (_) => ProductDetailBloc(
//                                                                          LoadingProductDetail())
//                                                                        ..add(
//                                                                            ProductDetailLoadEvent(
//                                                                          id: productDetailBloc
//                                                                              .listSimilarProduct[index]
//                                                                              .id,
//                                                                          person_id: context
//                                                                              .read<AccountBloc>()
//                                                                              .user
//                                                                              .id
//                                                                              .toString(),
//                                                                        ))),
//                                                                  BlocProvider
//                                                                      .value(
//                                                                    value: context
//                                                                        .read<
//                                                                            CartBloc>(),
//                                                                  ),
//                                                                ],
//                                                                child:
//                                                                    ProductDetail(
//                                                                  userId: context
//                                                                      .read<
//                                                                          AccountBloc>()
//                                                                      .user
//                                                                      .id!,
//                                                                  percentStar: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .percentStar,
//                                                                  countRating: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .countRating,
//                                                                  price: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .price,
//                                                                  productId: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .id,
//                                                                ))));
//                                              });
//                                        }),
//                                  ),
// SizedBox(height: 10,),
                                    /// Có thể bạn cũng thích
                                    if(context
                                        .read<AccountBloc>()
                                        .userId != 0) Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 10),
                                              color: Colors.white,
                                              child: Text(
                                                "Có thể bạn cũng thích",
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 5, vertical: 5),
                                              color: Color(0xffE7E7E7),
                                              height:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height -
                                                  300,
                                              child: CustomScrollView(
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  physics: flag == true
                                                      ? NeverScrollableScrollPhysics()
                                                      : ClampingScrollPhysics(),
                                                  controller: _scrollController,
                                                  scrollDirection: Axis
                                                      .vertical,
                                                  slivers: <Widget>[
                                                    SliverGrid(
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                        (MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width /
                                                            2 -
                                                            22 / 5) /
                                                            (MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height /
                                                                3 -
                                                                2.5),
                                                        mainAxisSpacing: 5,
                                                        crossAxisSpacing: 5,
                                                        //childAspectRatio: AppSizes.tile_width / AppSizes.tile_height,
                                                      ),
                                                      delegate:
                                                      SliverChildBuilderDelegate(
                                                            (
                                                            BuildContext context,
                                                            int index) {
                                                          return GestureDetector(
                                                              child: ProductCard(
                                                                onTapSimilar: () {
                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              _) =>
                                                                              BlocProvider
                                                                                  .value(
                                                                                value:
                                                                                context
                                                                                    .read<
                                                                                    CartBloc>(),
                                                                                child:
                                                                                BlocProvider(
                                                                                  create: (
                                                                                      _) =>
                                                                                  SimilarProductBloc(
                                                                                      InitialSimilarProductState())
                                                                                    ..add(
                                                                                        InitiateSimilarProductEvent(
                                                                                            productId: productDetailBloc
                                                                                                .listProductAlsoLike[index]
                                                                                                .id
                                                                                                .toString())),
                                                                                  child:
                                                                                  SimilarProductScreen(
                                                                                      interactingProduct: productDetailBloc
                                                                                          .listProductAlsoLike[index],
                                                                                      userId: widget
                                                                                          .userId),
                                                                                ),
                                                                              )));
                                                                },
                                                                onTapFavorite: () {},
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    3,
                                                                width: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width /
                                                                    2,
                                                                product: productDetailBloc
                                                                    .listProductAlsoLike[
                                                                index],
                                                                index: index,
                                                              ),
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            _) =>
                                                                            MultiBlocProvider(
                                                                                providers: [
                                                                                  BlocProvider(
                                                                                      create: (
                                                                                          _) =>
                                                                                      ProductDetailBloc(
                                                                                          InitialProductDetail())
                                                                                        ..add(
                                                                                            ProductDetailLoadEvent(
                                                                                              id: productDetailBloc
                                                                                                  .listProductAlsoLike[index]
                                                                                                  .id,
                                                                                              person_id: context
                                                                                                  .read<
                                                                                                  AccountBloc>()
                                                                                                  .user!
                                                                                                  .id
                                                                                                  .toString(),
                                                                                            ))),
                                                                                  BlocProvider
                                                                                      .value(
                                                                                    value: context
                                                                                        .read<
                                                                                        CartBloc>(),
                                                                                  ),
                                                                                  BlocProvider
                                                                                      .value(
                                                                                    value: context
                                                                                        .read<
                                                                                        AccountBloc>(),
                                                                                  ),
                                                                                ],
                                                                                child:
                                                                                ProductDetail(
                                                                                  userId:
                                                                                  context
                                                                                      .read<
                                                                                      AccountBloc>()
                                                                                      .user!
                                                                                      .id!,
                                                                                  percentStar:
                                                                                  productDetailBloc
                                                                                      .listProductAlsoLike[index]
                                                                                      .percentStar,
                                                                                  countRating:
                                                                                  productDetailBloc
                                                                                      .listProductAlsoLike[index]
                                                                                      .countRating,
                                                                                  price:
                                                                                  productDetailBloc
                                                                                      .listProductAlsoLike[index]
                                                                                      .price,
                                                                                  productId:
                                                                                  productDetailBloc
                                                                                      .listProductAlsoLike[index]
                                                                                      .id,
                                                                                ))));
                                                              });
                                                        },
                                                        childCount: productDetailBloc
                                                            .listProductAlsoLike
                                                            .length,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            if (state is LoadingProductAlsoLikeState)
                                              Center(child: Container(
                                                width: 30,
                                                height: 30,
                                                child: CircularProgressIndicator(
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                spreadRadius: 1,
                                blurRadius: 2)
                          ]),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    if (context
                                        .read<AccountBloc>()
                                        .userId != 0) {
                                      setState(() {
                                        productDetailBloc.productDetail
                                            .isLiked =
                                        !productDetailBloc
                                            .productDetail.isLiked;
                                      });

                                      if (widget.isNavigatedFromFavorite) {
                                        context.read<FavoriteBloc>().add(
                                            FavoriteTap(
                                                person_id: widget.userId
                                                    .toString(),
                                                index: context
                                                    .read<FavoriteBloc>()
                                                    .index,
                                                product_id:
                                                widget.productId.toString()));
                                      } else {
                                        productDetailBloc.add(FavoriteTapEvent(
                                            person_id: widget.userId.toString(),
                                            product_id: productDetailBloc
                                                .productDetail.id
                                                .toString()));
                                      }
                                    }
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Icon(
                                        productDetailBloc.productDetail.isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: productDetailBloc
                                            .productDetail.isLiked
                                            ? Colors.redAccent
                                            : Colors.black.withOpacity(0.6),
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                color: Colors.black.withOpacity(0.6),
                              ),
                              Expanded(
                                flex: 4,
                                child: InkWell(
                                  onTap: () async {
                                    if (context
                                        .read<AccountBloc>()
                                        .userId != 0)
                                      await showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return BlocProvider.value(
                                              value:
                                              context.read<ProductDetailBloc>(),
                                              child: AttributesSheet(
                                                images: images,
                                                hasMuaHang: false,
                                                hasThemGioHang: true,
                                              ),
                                            );
                                          }).then((value) {
                                        if (value == "Thêm vào giỏ hàng") {
//                                      setState(() {
//                                        isAnimating = true;
//                                      });
                                          productDetailBloc.add(AddtocartEvent(
                                              person_id: widget.userId
                                                  .toString(),
                                              product_id: productDetailBloc
                                                  .productDetail.id
                                                  .toString(),
                                              option_amount_id:
                                              productDetailBloc.optionProductId,
                                              amount: productDetailBloc
                                                  .amount));

//                                      context.read<CartBloc>().add(GetCartEvent(
//                                          person_id: widget.userId.toString()));
//                                      animationController.reset();
//                                      animationController.forward();
                                        }
                                      });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.black.withOpacity(0.6),
                                          size: 25,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Thêm vào giỏ hàng",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: InkWell(
                                  onTap: () async {
                                    if (context
                                        .read<AccountBloc>()
                                        .userId != 0)
                                      await showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return BlocProvider.value(
                                              value: context.read<
                                                  ProductDetailBloc>(),
                                              child: AttributesSheet(
                                                images: images,
                                                hasMuaHang: true,
                                                hasThemGioHang: false,
                                              ),
                                            );
                                          }).then((value) {
                                        if (value == "Mua ngay") {
                                          var optionProduct = productDetailBloc
                                              .productDetail.optionProducts
                                              .firstWhere((element) =>
                                          element.productOptionId
                                              .toString() ==
                                              productDetailBloc
                                                  .optionProductId);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      BlocProvider.value(
                                                        value: context.read<
                                                            CartBloc>(),
                                                        child: BlocProvider(
                                                          create: (_) =>
                                                          AddressBloc(
                                                              LoadAddress())
                                                            ..add(
                                                                InitialAddressEvent(
                                                                    userId: widget
                                                                        .userId
                                                                        .toString())),
                                                          child: BlocProvider
                                                              .value(
                                                            value: context.read<
                                                                ProductBloc>(),
                                                            child: BlocProvider
                                                                .value(
                                                              value: context
                                                                  .read<
                                                                  AccountBloc>(),
                                                              child: PaymentScreen(
                                                                userId: widget
                                                                    .userId
                                                                    .toString(),
                                                                listItems: [
                                                                  CartItem
                                                                      .CartItem(
                                                                      cartId: 0,
                                                                      productId: productDetailBloc
                                                                          .productDetail
                                                                          .id,
                                                                      nameProduct: productDetailBloc
                                                                          .productDetail
                                                                          .name,
                                                                      amount: productDetailBloc
                                                                          .amount,
                                                                      optionProduct: CartItem
                                                                          .OptionProduct(
                                                                          productOptionId: optionProduct
                                                                              .productOptionId,
                                                                          price: CartItem
                                                                              .Price(
                                                                              value: optionProduct
                                                                                  .price
                                                                                  .value,
                                                                              id: optionProduct
                                                                                  .price
                                                                                  .id),
                                                                          quantity: CartItem
                                                                              .Quantity(
                                                                              value: optionProduct
                                                                                  .quantity
                                                                                  .value,
                                                                              id: optionProduct
                                                                                  .quantity
                                                                                  .id),
                                                                          color: CartItem
                                                                              .Color(
                                                                              value: productDetailBloc
                                                                                  .options
                                                                                  .length >
                                                                                  1
                                                                                  ? productDetailBloc
                                                                                  .options[1]
                                                                                  : "",
                                                                              id: 0),
                                                                          size: CartItem
                                                                              .Size(
                                                                              id: 0,
                                                                              value: productDetailBloc
                                                                                  .options[0]),
                                                                          image: CartItem
                                                                              .Image(
                                                                              value: images[0],
                                                                              id: 0)))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )));
                                        }
                                      });
                                  },
                                  child: Container(
                                    decoration:
                                    BoxDecoration(color: Color(0xffF34646)),
                                    child: Center(
                                      child: Text(
                                        "Mua ngay",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isAnimating)
                      AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return Positioned(
                              right: (MediaQuery
                                  .of(context)
                                  .size
                                  .width - 60) -
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .width - 70 - 60) *
                                      animation.value,
                              top: (MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35 +
                                  180) -
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.35 +
                                      150) *
                                      animation.value,
                              child: CachedNetworkImage(
                                imageUrl: images[selectedIndex],
//                        height: 40 - animation.value * 20,
//                        width: 55 - animation.value * 30,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageBuilder: (context, image) =>
                                    CircleAvatar(
                                      backgroundImage: image,
                                      radius: 40 - 30 * animation.value,
                                    ),
                              ),
                            );
                          }),

                    //Appbar
                    Container(
                        height: 80,
                        child: AnimatedBuilder(
                          animation: _ColorAnimationController,
                          builder: (context, child) =>
                              AppBar(
                                elevation: elevation,
                                backgroundColor: _colorTween.value,
                                leadingWidth: 50,
                                leading: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _workOutTween.value),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                      color: _iconTween.value,
                                    ),
                                  ),
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                            return BlocProvider.value(
                                              value: context.read<CartBloc>(),
                                              child: BlocProvider.value(
                                                value: context.read<
                                                    AccountBloc>(),
                                                child: BlocProvider.value(
                                                  value: context.read<
                                                      ProductBloc>(),
                                                  child: CartScreen(
                                                    person_id: widget.userId,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _workOutTween.value),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: _iconTween.value,
                                              size: 30,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 5,
                                            child: Container(
                                                height: 17,
                                                width: 17,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                  child: BlocBuilder<CartBloc,
                                                      CartState>(
                                                    builder: (context, state) {
                                                      if (state is InitialCart)
                                                        return Text(
                                                          "",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 10),
                                                        );
                                                      countCart = context
                                                          .read<CartBloc>()
                                                          .list_data
                                                          .length;
                                                      return Text(
                                                        countCart.toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 10),
                                                      );
                                                    },
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _workOutTween.value),
                                    child: Icon(
                                      Icons.more_horiz_outlined,
                                      color: _iconTween.value,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                        )),
                    if (state is LoadingAddtoCart)
                      Positioned(
                          top: 10,
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            color: Colors.white.withOpacity(0.7),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.redAccent,
                              ),
                            ),
                          ))
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xffF34646),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          },
        ),
      ) :
      BlocListener(
        bloc: context.read<ProductDetailBloc>(),
        listener: (context,state){
          if(state is LoadSuccessProductDetail )
          {
            DateTime endTime = DateFormat('HH:mm:ss').parse(context.read<ProductDetailBloc>().productDetail.flashSaleProduct!.flashSale!.endTime!);
            setState(() {
              time = endTime.hour * 3600 + endTime.minute * 60 +
                  endTime.second - (DateTime
                  .now()
                  .hour * 3600 + DateTime
                  .now()
                  .minute * 60 + DateTime
                  .now()
                  .second);
            });
          }
        },
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is LoadingProductDetail ||
                state is InitialProductDetail ||
                state is LoadingProductDetailReset)
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.withOpacity(0.5),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.35,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor:
                                      Colors.grey.withOpacity(0.5),
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            "loading..................",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color(0xffF65151),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor:
                                      Colors.grey.withOpacity(0.5),
                                      child: Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 20,
                                          child: Center(
                                              child: Text(
                                                "loading...",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                    decoration:
                                                    TextDecoration.lineThrough,
                                                    decorationThickness: 2,
                                                    decorationColor: Colors
                                                        .black54,
                                                    decorationStyle:
                                                    TextDecorationStyle.solid),
                                              ))),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: Container(
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration:
                                      BoxDecoration(color: Color(0xffF9CF3B)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              "..." + "%",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffF65151)),
                                            ),
                                            Text(
                                              "...",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
//                        SizedBox(
//                          height: 10,
//                        ),
                          Row(
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 30,
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    child: Text(
                                      "loading.....loading.......loading......",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    )),
                              ),
                            ],
                          ),

                          Row(
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: SizedBox(
                                  height: 20,
                                  child: RatingBarIndicator(
                                    rating: 0,
                                    itemBuilder: (context, index) =>
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.5),
                                child: Container(
                                  height: 15,
                                  alignment: Alignment.center,
                                  child: Text(
                                    ".......",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 20,
                                width: 2,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Đã bán " + ".........",
                                style:
                                TextStyle(color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Color(0xffE7E7E7),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Chọn loại hàng (màu sắc, kích thước ,...)",
                              style: TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 90,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  if (index == 3)
                                    return InkWell(
                                      onTap: () async {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffC4C4C4)
                                                .withOpacity(0.3),
                                            border: Border.all(
                                              color: Colors.black26,
                                              width: 1,
                                            )),
                                        height: 70,
                                        width: 55,
                                        child: Center(
                                          child: Icon(
                                            Icons.more_horiz_outlined,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.grey.withOpacity(0.5),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: 5,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black26,
                                            width: 1,
                                          )),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 55,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xffE7E7E7),
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CustomIcon.tick,
                                color: Color(0xffF65151),
                                size: 12,
                              ),
                              Text(
                                "Miễn phí trả hàng",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CustomIcon.tick,
                                color: Color(0xffF65151),
                                size: 12,
                              ),
                              Text(
                                "Giao miễn phí",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CustomIcon.tick,
                                color: Color(0xffF65151),
                                size: 12,
                              ),
                              Text(
                                "Chất lượng đảm bảo",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xffE7E7E7),
                      height: 10,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Mô tả",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black26,
                      height: 1,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "loading...........loading..... \n loading...........loading..... \n loading...........loading..... \n ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    "<Xem thêm>",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () async {},
//
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffE7E7E7),
                      height: 10,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Chi tiết sản phẩm ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black26,
                      height: 1,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ProductPropertyDetail(
                              firstText: "THƯƠNG HIỆU",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "CHẤT LIỆU",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "MỤC ĐÍCH SD",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "MÙA PHÙ HỢP",
                              secondText: "loading............",
                            ),
                            ProductPropertyDetail(
                              firstText: "NƠI SX",
                              secondText: "loading............",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            else {
              images = productDetailBloc.productDetail.attributes
                  .firstWhere((element) => element.code == "image")
                  .options
                  .map((e) => e.value)
                  .toList();
              return Container(
                color: Colors.white,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.axis == Axis.vertical) {
                                _ColorAnimationController.animateTo(scrollInfo
                                    .metrics.pixels /
                                    (MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.35 -
                                        80));
                                if (scrollInfo.metrics.pixels >=
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.35 -
                                        100 &&
                                    elevation == 0) {
                                  elevation = 1;
                                }
                                if (scrollInfo.metrics.pixels <
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.35 -
                                        100) {
                                  elevation = 0;
                                }
                                return true;
                              }
                              return true;
                            },
                            child: RefreshIndicator(
                              color: Colors.redAccent,
                              onRefresh: () async {
                                await Future.delayed(
                                  Duration(seconds: 2),
                                );
                                productDetailBloc.add(ProductDetailResetEvent(
                                    id: productDetailBloc.productDetail.id,
                                    person_id: widget.userId.toString()));
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                controller: _scrollController2,
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        CarouselSlider(
                                          items: List.generate(images.length,
                                                  (index) {
                                                return CachedNetworkImage(
                                                  imageUrl: images[index],
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width -
                                                      200,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                      Icon(Icons.error),
                                                );
                                              }),
                                          options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            },
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.35,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 15,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 8),
                                            decoration: BoxDecoration(
                                                color:
                                                Colors.black.withOpacity(0.5),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                (_current + 1).toString() +
                                                    "/" +
                                                    images.length.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
//
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(productDetailBloc.productDetail
                                        .flashSaleProduct != null)
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange
                                                .withOpacity(0.7)),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween, children: [
                                            Container(
                                              decoration: BoxDecoration(

                                                  border: Border.all(
                                                      color: Colors
                                                          .yellowAccent,
                                                      width: 1)),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center, children: [
                                                Container(
                                                  color: Colors.yellowAccent,
                                                  child: Icon(Icons.flash_on_sharp,
                                                    size: 20, color: Colors
                                                        .deepOrange
                                                        .withOpacity(0.7),),
                                                ),
                                                Text("FLASH SALE",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],),
                                            ),
                                            Text(productDetailBloc.productDetail.flashSaleProduct!.saleAmount!.toString() + "Đã bán",
                                              style: TextStyle(fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                          ),
                                          SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(NumberFormat
                                                      .simpleCurrency(
                                                      locale:
                                                      "vi")
                                                      .format(widget
                                                      .price.priceMin*
                                          (1 +
                                          (productDetailBloc
                                              .productDetail
                                              .promotionPercent /
                                              100)))
                                                      .toString(), style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors
                                                          .black38,
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                      decorationThickness:
                                                      2,
                                                      decorationColor:
                                                      Colors
                                                          .black54,
                                                      decorationStyle:
                                                      TextDecorationStyle
                                                          .solid),),
                                                  SizedBox(width: 5,),
                                                  Text(NumberFormat
                                                      .simpleCurrency(
                                                      locale:
                                                      "vi")
                                                      .format(widget
                                                      .price.priceMin)
                                                      .toString(), style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,)),
                                                ],
                                              ),
                                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("KẾT THÚC TRONG", style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,)),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.symmetric(
                                                                vertical: 2, horizontal: 3),
                                                            decoration: BoxDecoration(
                                                              color: Colors.black,
                                                              borderRadius: BorderRadius.circular(1),),
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
                                                ],)
                                            ],)
                                        ],
                                        ),
                                      ),
                                    Container(
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                    Container(
                                      decoration:
                                      BoxDecoration(color: Color(0xffffffff)),
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                      Alignment.topCenter,
                                                      height: 30,
                                                      child: Center(
                                                        child: Text(
                                                          NumberFormat
                                                              .simpleCurrency(
                                                              locale:
                                                              "vi")
                                                              .format(widget
                                                              .price.priceMin)
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 20,
                                                            color:
                                                            Color(0xffF65151),
                                                          ),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    productDetailBloc
                                                        .productDetail
                                                        .promotion
                                                        ? Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        height: 20,
                                                        child: Center(
                                                            child: Text(
                                                              NumberFormat
                                                                  .simpleCurrency(
                                                                  locale:
                                                                  "vi")
                                                                  .format((widget
                                                                  .price
                                                                  .priceMin *
                                                                  (1 +
                                                                      (productDetailBloc
                                                                          .productDetail
                                                                          .promotionPercent /
                                                                          100)))),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  decorationThickness:
                                                                  2,
                                                                  decorationColor:
                                                                  Colors
                                                                      .black54,
                                                                  decorationStyle:
                                                                  TextDecorationStyle
                                                                      .solid),
                                                            )))
                                                        : Container(),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              productDetailBloc
                                                  .productDetail.promotion
                                                  ? Container(
                                                child: Center(
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    BoxDecoration(
                                                        color: Color(
                                                            0xffF9CF3B)),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            productDetailBloc
                                                                .productDetail
                                                                .promotionPercent
                                                                .toString() +
                                                                "%",
                                                            style: TextStyle(
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Color(
                                                                    0xffF65151)),
                                                          ),
                                                          Text(
                                                            "GIẢM",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                letterSpacing:
                                                                0.5),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : Container(),
                                            ],
                                          ),
//                        SizedBox(
//                          height: 10,
//                        ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width -
                                                      30,
                                                  alignment: Alignment.centerLeft,
                                                  height: 50,
                                                  child: Text(
                                                    productDetailBloc
                                                        .productDetail.name,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      letterSpacing: 0.5,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  )),
                                            ],
                                          ),

                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                                child: RatingBarIndicator(
                                                  rating: calAverageStarRating(
                                                      context
                                                          .read<
                                                          ProductDetailBloc>()
                                                          .productDetail
                                                          .ratingStar),
                                                  itemBuilder: (context, index) =>
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                  itemCount: 5,
                                                  itemSize: 20.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 15,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  widget.percentStar.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 20,
                                                width: 2,
                                                color: Colors.black54,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Đã bán " +
                                                    productDetailBloc
                                                        .productDetail.orderCount
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 10,
                                      color: Color(0xffE7E7E7),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "Chọn loại hàng (màu sắc, kích thước ,...)",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          BlocListener(
                                            bloc: context.read<
                                                ProductDetailBloc>(),
                                            listener: (context, state) {
                                              if (state is AddtoCartSuccess) {
                                                context
                                                    .read<CartBloc>()
                                                    .add(GetCartEvent(
                                                    person_id: widget
                                                        .userId
                                                        .toString()));
                                                setState(() {
                                                  isAnimating = true;
                                                });
                                                animationController
                                                    .reset();
                                                animationController
                                                    .forward();
                                              }
                                            },
                                            child: Container(
                                              height: 90,
                                              child: ListView.builder(
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  padding: EdgeInsets.all(10),
                                                  itemCount: images.length + 1,
                                                  itemBuilder: (context, index) {
                                                    if (index == images.length)
                                                      return InkWell(
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                              context: context,
                                                              builder: (_) {
                                                                return BlocProvider
                                                                    .value(
                                                                  value: context
                                                                      .read<
                                                                      ProductDetailBloc>(),
                                                                  child:
                                                                  AttributesSheet(
                                                                    images: images,
                                                                    hasMuaHang: true,
                                                                    hasThemGioHang: true,
                                                                  ),
                                                                );
                                                              }).then((value) {
                                                            if (value ==
                                                                "Thêm vào giỏ hàng") {
                                                              productDetailBloc
                                                                  .add(
                                                                  AddtocartEvent(
                                                                      person_id: widget
                                                                          .userId
                                                                          .toString(),
                                                                      product_id:
                                                                      productDetailBloc
                                                                          .productDetail
                                                                          .id
                                                                          .toString(),
                                                                      option_amount_id:
                                                                      productDetailBloc
                                                                          .optionProductId,
                                                                      amount:
                                                                      productDetailBloc
                                                                          .amount));

//
                                                            }
                                                            if (value ==
                                                                "Mua ngay") {
                                                              var optionProduct = productDetailBloc
                                                                  .productDetail
                                                                  .optionProducts
                                                                  .firstWhere((
                                                                  element) =>
                                                              element
                                                                  .productOptionId
                                                                  .toString() ==
                                                                  productDetailBloc
                                                                      .optionProductId);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          _) =>
                                                                          BlocProvider
                                                                              .value(
                                                                            value: context
                                                                                .read<
                                                                                CartBloc>(),
                                                                            child: BlocProvider(
                                                                              create: (
                                                                                  _) =>
                                                                              AddressBloc(
                                                                                  LoadAddress())
                                                                                ..add(
                                                                                    InitialAddressEvent(
                                                                                        userId: widget
                                                                                            .userId
                                                                                            .toString())),
                                                                              child: BlocProvider
                                                                                  .value(
                                                                                value: context
                                                                                    .read<
                                                                                    ProductBloc>(),
                                                                                child: BlocProvider
                                                                                    .value(
                                                                                  value: context
                                                                                      .read<
                                                                                      AccountBloc>(),
                                                                                  child: PaymentScreen(
                                                                                    userId: widget
                                                                                        .userId
                                                                                        .toString(),
                                                                                    listItems: [
                                                                                      CartItem
                                                                                          .CartItem(
                                                                                          cartId: 0,
                                                                                          productId: productDetailBloc
                                                                                              .productDetail
                                                                                              .id,
                                                                                          nameProduct: productDetailBloc
                                                                                              .productDetail
                                                                                              .name,
                                                                                          amount: productDetailBloc
                                                                                              .amount,
                                                                                          optionProduct: CartItem
                                                                                              .OptionProduct(
                                                                                              productOptionId: optionProduct
                                                                                                  .productOptionId,
                                                                                              price: CartItem
                                                                                                  .Price(
                                                                                                  value: optionProduct
                                                                                                      .price
                                                                                                      .value,
                                                                                                  id: optionProduct
                                                                                                      .price
                                                                                                      .id),
                                                                                              quantity: CartItem
                                                                                                  .Quantity(
                                                                                                  value: optionProduct
                                                                                                      .quantity
                                                                                                      .value,
                                                                                                  id: optionProduct
                                                                                                      .quantity
                                                                                                      .id),
                                                                                              color: CartItem
                                                                                                  .Color(
                                                                                                  value: productDetailBloc
                                                                                                      .options
                                                                                                      .length >
                                                                                                      1
                                                                                                      ? productDetailBloc
                                                                                                      .options[1]
                                                                                                      : "",
                                                                                                  id: 0),
                                                                                              size: CartItem
                                                                                                  .Size(
                                                                                                  id: 0,
                                                                                                  value: productDetailBloc
                                                                                                      .options[0]),
                                                                                              image: CartItem
                                                                                                  .Image(
                                                                                                  value: images[0],
                                                                                                  id: 0)))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )));
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffC4C4C4)
                                                                  .withOpacity(
                                                                  0.3),
                                                              border: Border.all(
                                                                color:
                                                                Colors.black26,
                                                                width: 1,
                                                              )),
                                                          height: 70,
                                                          width: 55,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .more_horiz_outlined,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        right: 5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.black26,
                                                            width: 1,
                                                          )),
                                                      child: Stack(
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl: productDetailBloc
                                                                .productDetail
                                                                .attributes
                                                                .firstWhere(
                                                                    (element) =>
                                                                element
                                                                    .code ==
                                                                    "image")
                                                                .options
                                                                .map((e) =>
                                                            e.value)
                                                                .toList()[index],
                                                            height: 70,
                                                            width: 55,
                                                            fit: BoxFit.fill,
                                                            placeholder: (context,
                                                                url) =>
                                                                Center(
                                                                    child:
                                                                    CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                url, error) =>
                                                                Icon(Icons.error),
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
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CustomIcon.tick,
                                                color: Color(0xffF65151),
                                                size: 12,
                                              ),
                                              Text(
                                                "Miễn phí trả hàng",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CustomIcon.tick,
                                                color: Color(0xffF65151),
                                                size: 12,
                                              ),
                                              Text(
                                                "Giao miễn phí",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CustomIcon.tick,
                                                color: Color(0xffF65151),
                                                size: 12,
                                              ),
                                              Text(
                                                "Chất lượng đảm bảo",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        "Mô tả",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            productDetailBloc
                                                .productDetail.shortDescription,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Text(
                                                  "<Xem thêm>",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) {
                                                        return Stack(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 40,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  SingleChildScrollView(
                                                                    scrollDirection:
                                                                    Axis.vertical,
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                        10),
                                                                    child:
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .only(
                                                                              topLeft:
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                              topRight: Radius
                                                                                  .circular(
                                                                                  10))),
                                                                      padding: EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                          10),
                                                                      child: Html(
                                                                        data: productDetailBloc
                                                                            .productDetail
                                                                            .description,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Positioned(
                                                                top: 5,
                                                                right: 5,
                                                                child: Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color:
                                                                  Colors.grey,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
//
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        "Chi tiết sản phẩm ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          if(productDetailBloc
                                              .productDetail.brand !=
                                              null) ProductPropertyDetail(
                                            firstText: "THƯƠNG HIỆU",
                                            secondText: productDetailBloc
                                                .productDetail.brand!.name!,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "CHẤT LIỆU",
                                            secondText: productDetailBloc
                                                .productDetail.material,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "MỤC ĐÍCH SD",
                                            secondText: productDetailBloc
                                                .productDetail.purpose,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "MÙA PHÙ HỢP",
                                            secondText: productDetailBloc
                                                .productDetail.suitableSeason,
                                          ),
                                          ProductPropertyDetail(
                                            firstText: "NƠI SX",
                                            secondText: productDetailBloc
                                                .productDetail.madeIn,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffE7E7E7),
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Đánh giá",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                    Column(
                                      children: List.generate(
                                          productDetailBloc.productDetail.ratings
                                              .listrating.length, (index) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        children: [
//                                                CircleAvatar(
//                                                  backgroundImage: NetworkImage(
//                                                      productDetailBloc.productDetail.ratings.listrating[index].imageAvatar),
//                                                  radius: 15,
//                                                ),
                                                          Container(
//                                                  margin: EdgeInsets.only(bottom: 5), //10
                                                            height: 35, //140
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                              shape:
                                                              BoxShape.circle,
//                                                    border: Border.all(
//                                                      color: Colors.white,
//                                                      width: 2, //8
//                                                    ),
                                                              image:
                                                              DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image:
                                                                  NetworkImage(
                                                                    productDetailBloc
                                                                        .productDetail
                                                                        .ratings
                                                                        .listrating[
                                                                    index]
                                                                        .imageAvatar,
                                                                  )),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .blue
                                                                      .withOpacity(
                                                                      0.5),
                                                                  spreadRadius: 1,
                                                                  blurRadius: 1,
                                                                  offset: Offset(
                                                                      0,
                                                                      0), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            productDetailBloc
                                                                .productDetail
                                                                .ratings
                                                                .listrating[index]
                                                                .userName,
                                                            style: TextStyle(
                                                                color:
                                                                Colors.black,
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                0.5,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                        child: RatingBarIndicator(
                                                          rating:
                                                          productDetailBloc
                                                              .productDetail
                                                              .ratings
                                                              .listrating[
                                                          index]
                                                              .star
                                                              .toDouble(),
                                                          itemBuilder:
                                                              (context, index) =>
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                          itemCount: 5,
                                                          itemSize: 20.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 35,
                                                      ),
                                                      Text(productDetailBloc
                                                          .productDetail
                                                          .ratings
                                                          .listrating[index]
                                                          .comment),
                                                    ],
                                                  ),
                                                  if (productDetailBloc
                                                      .productDetail
                                                      .ratings
                                                      .listrating[index]
                                                      .imageRating
                                                      .length >
                                                      0)
                                                    Container(
                                                        margin:
                                                        EdgeInsets.fromLTRB(
                                                            15, 15, 0, 15),
                                                        height: 100,
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                            Axis.horizontal,
                                                            itemCount:
                                                            productDetailBloc
                                                                .productDetail
                                                                .ratings
                                                                .listrating[
                                                            index]
                                                                .imageRating
                                                                .length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              String image =
                                                              productDetailBloc
                                                                  .productDetail
                                                                  .ratings
                                                                  .listrating[
                                                              index]
                                                                  .imageRating[i];
                                                              return Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                      border: Border
                                                                          .all(
                                                                        width:
                                                                        1,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                            0.2),
                                                                      ),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors
                                                                                .black26,
                                                                            blurRadius:
                                                                            1,
                                                                            spreadRadius:
                                                                            1,
                                                                            offset: Offset(
                                                                                0,
                                                                                0))
                                                                      ]),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      15),
                                                                  child:
                                                                  CachedNetworkImage(
                                                                    imageUrl:
                                                                    image,
                                                                    placeholder: (
                                                                        context,
                                                                        url) =>
                                                                        Center(
                                                                            child:
                                                                            CircularProgressIndicator()),
                                                                    errorWidget: (
                                                                        context,
                                                                        url,
                                                                        error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .width /
                                                                        4,
                                                                    height: 100,
                                                                    colorBlendMode:
                                                                    BlendMode
                                                                        .darken,
                                                                  ));
                                                            })),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              color: Colors.black26,
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (_) =>
                                                          BlocProvider.value(
                                                            value:
                                                            productDetailBloc,
                                                            child: BlocProvider(
                                                                create: (
                                                                    BuildContext context) =>
                                                                RatingBloc(
                                                                    InitialRatingState())
                                                                  ..add(
                                                                      InitiateRatingEvent(
                                                                          product_id: widget
                                                                              .productId
                                                                              .toString())),
                                                                child:
                                                                ReviewScreen()),
                                                          )));
                                            },
                                            child: Center(
                                              child: Text(
                                                "<Xem tất cả>",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    /// sản phẩm tương tự
//                                  Row(
//                                    children: [
//                                      Container(
//                                        width: MediaQuery.of(context).size.width,
//                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                                        color: Colors.white,
//                                        child: Text(
//                                          "Sản phẩm tương tự",
//                                          style: TextStyle(
//                                            color: Colors.black87,
//                                            fontSize: 18,
//                                            letterSpacing: 0.5,
//                                            fontWeight: FontWeight.w500,
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  if(state is LoadingRecommendAndAlsoLikeProduct)
//                                    Shimmer.fromColors(
//                                      baseColor: Colors.grey,
//                                      highlightColor: Colors.grey.withOpacity(0.5),
//                                        child: Container(
//                                          height: MediaQuery.of(context).size.height /
//                                              4 <
//                                              200
//                                              ? 200
//                                              : MediaQuery.of(context).size.height /
//                                              4,
//                                          width: MediaQuery.of(context).size.width,
//                                          child: ListView.builder(
//                                              scrollDirection: Axis.horizontal,
//                                              itemCount: 11,
//                                              itemBuilder: (context, index) {
//                                                if (index == 10)
//                                                  return InkWell(
//                                                    onTap: (){
//
//                                                    },
//                                                    child: Container(
//                                                        height: MediaQuery.of(context)
//                                                            .size
//                                                            .height /
//                                                            4 <
//                                                            200
//                                                            ? 200
//                                                            : MediaQuery.of(context)
//                                                            .size
//                                                            .height /
//                                                            4,
//                                                        width: MediaQuery.of(context)
//                                                            .size
//                                                            .width /
//                                                            3,
//                                                        margin:
//                                                        EdgeInsets.only(right: 5),
//                                                        child: Center(
//                                                          child: Container(
//                                                              height: 60,
//                                                              child: Column(
//                                                                children: [
//                                                                  Container(
//                                                                      height: 30,
//                                                                      width: 30,
//                                                                      decoration: BoxDecoration(
//                                                                          border: Border.all(
//                                                                              width: 1,
//                                                                              color: Colors
//                                                                                  .redAccent)),
//                                                                      child: Center(
//                                                                          child: Icon(
//                                                                            Icons
//                                                                                .arrow_forward_ios_rounded,
//                                                                            size: 10,
//                                                                          ))),
//                                                                  SizedBox(
//                                                                    height: 10,
//                                                                  ),
//                                                                  Text(
//                                                                    "Xem thêm",
//                                                                    style: TextStyle(
//                                                                        fontSize: 14,
//                                                                        letterSpacing:
//                                                                        0.5,
//                                                                        color: Colors
//                                                                            .redAccent),
//                                                                  )
//                                                                ],
//                                                              )),
//                                                        )),
//                                                  );
//                                                return Container(
//                                                  margin:
//                                                  EdgeInsets.only(right: 5),
//                                                  child: Container(
//
//                                                    height: MediaQuery.of(context)
//                                                        .size
//                                                        .height /
//                                                        4 <
//                                                        200
//                                                        ? 200
//                                                        : MediaQuery.of(context)
//                                                        .size
//                                                        .height /
//                                                        4,
//                                                    width: MediaQuery.of(context)
//                                                        .size
//                                                        .width /
//                                                        3,
//                                                  ),
//                                                );
//                                              }),
//                                        ),
//                                    )
//                                    else
//                                  Container(
//                                    height: MediaQuery.of(context).size.height /
//                                                4 <
//                                            200
//                                        ? 200
//                                        : MediaQuery.of(context).size.height /
//                                            4,
//                                    width: MediaQuery.of(context).size.width,
//                                    child: ListView.builder(
//                                        scrollDirection: Axis.horizontal,
//                                        itemCount: 11,
//                                        itemBuilder: (context, index) {
//                                          if (index == 10)
//                                            return InkWell(
//                                              onTap: (){
//
//                                              },
//                                              child: Container(
//                                                  height: MediaQuery.of(context)
//                                                                  .size
//                                                                  .height /
//                                                              4 <
//                                                          200
//                                                      ? 200
//                                                      : MediaQuery.of(context)
//                                                              .size
//                                                              .height /
//                                                          4,
//                                                  width: MediaQuery.of(context)
//                                                          .size
//                                                          .width /
//                                                      3,
//                                                  margin:
//                                                      EdgeInsets.only(right: 5),
//                                                  child: Center(
//                                                    child: Container(
//                                                        height: 60,
//                                                        child: Column(
//                                                          children: [
//                                                            Container(
//                                                                height: 30,
//                                                                width: 30,
//                                                                decoration: BoxDecoration(
//                                                                    border: Border.all(
//                                                                        width: 1,
//                                                                        color: Colors
//                                                                            .redAccent)),
//                                                                child: Center(
//                                                                    child: Icon(
//                                                                  Icons
//                                                                      .arrow_forward_ios_rounded,
//                                                                  size: 10,
//                                                                ))),
//                                                            SizedBox(
//                                                              height: 10,
//                                                            ),
//                                                            Text(
//                                                              "Xem thêm",
//                                                              style: TextStyle(
//                                                                  fontSize: 14,
//                                                                  letterSpacing:
//                                                                      0.5,
//                                                                  color: Colors
//                                                                      .redAccent),
//                                                            )
//                                                          ],
//                                                        )),
//                                                  )),
//                                            );
//                                          return GestureDetector(
//                                              child: Container(
//                                                margin:
//                                                    EdgeInsets.only(right: 5),
//                                                child: ProductCard(
//                                                  onTapFavorite: () {},
//                                                  height: MediaQuery.of(context)
//                                                                  .size
//                                                                  .height /
//                                                              4 <
//                                                          200
//                                                      ? 200
//                                                      : MediaQuery.of(context)
//                                                              .size
//                                                              .height /
//                                                          4,
//                                                  width: MediaQuery.of(context)
//                                                          .size
//                                                          .width /
//                                                      3,
//                                                  product: productDetailBloc
//                                                          .listSimilarProduct[
//                                                      index],
//                                                  index: index,
//                                                ),
//                                              ),
//                                              onTap: () {
//                                                Navigator.push(
//                                                    context,
//                                                    MaterialPageRoute(
//                                                        builder: (_) =>
//                                                            MultiBlocProvider(
//                                                                providers: [
//                                                                  BlocProvider(
//                                                                      create: (_) => ProductDetailBloc(
//                                                                          LoadingProductDetail())
//                                                                        ..add(
//                                                                            ProductDetailLoadEvent(
//                                                                          id: productDetailBloc
//                                                                              .listSimilarProduct[index]
//                                                                              .id,
//                                                                          person_id: context
//                                                                              .read<AccountBloc>()
//                                                                              .user
//                                                                              .id
//                                                                              .toString(),
//                                                                        ))),
//                                                                  BlocProvider
//                                                                      .value(
//                                                                    value: context
//                                                                        .read<
//                                                                            CartBloc>(),
//                                                                  ),
//                                                                ],
//                                                                child:
//                                                                    ProductDetail(
//                                                                  userId: context
//                                                                      .read<
//                                                                          AccountBloc>()
//                                                                      .user
//                                                                      .id!,
//                                                                  percentStar: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .percentStar,
//                                                                  countRating: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .countRating,
//                                                                  price: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .price,
//                                                                  productId: productDetailBloc
//                                                                      .listSimilarProduct[
//                                                                          index]
//                                                                      .id,
//                                                                ))));
//                                              });
//                                        }),
//                                  ),
// SizedBox(height: 10,),
                                    /// Có thể bạn cũng thích
                                    /*  if(context.read<AccountBloc>().userId !=0)*/
                                    Row(
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          color: Colors.white,
                                          child: Text(
                                            "Có thể bạn cũng thích",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    /*if(context.read<AccountBloc>().userId !=0)*/
                                    Stack(
                                      children: <Widget>[
                                        Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 5, vertical: 5),
                                          color: Color(0xffE7E7E7),
                                          height:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height -
                                              300,
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
                                                    childAspectRatio:
                                                    (MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        2 -
                                                        22 / 5) /
                                                        (MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height /
                                                            3 -
                                                            2),
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 5,
                                                    //childAspectRatio: AppSizes.tile_width / AppSizes.tile_height,
                                                  ),
                                                  delegate:
                                                  SliverChildBuilderDelegate(
                                                        (BuildContext context,
                                                        int index) {
                                                      return GestureDetector(
                                                          child: ProductCard(
                                                            onTapSimilar: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          _) =>
                                                                          BlocProvider
                                                                              .value(
                                                                            value:
                                                                            context
                                                                                .read<
                                                                                CartBloc>(),
                                                                            child:
                                                                            BlocProvider(
                                                                              create: (
                                                                                  _) =>
                                                                              SimilarProductBloc(
                                                                                  InitialSimilarProductState())
                                                                                ..add(
                                                                                    InitiateSimilarProductEvent(
                                                                                        productId: productDetailBloc
                                                                                            .listProductAlsoLike[index]
                                                                                            .id
                                                                                            .toString())),
                                                                              child:
                                                                              SimilarProductScreen(
                                                                                  interactingProduct: productDetailBloc
                                                                                      .listProductAlsoLike[index],
                                                                                  userId: widget
                                                                                      .userId),
                                                                            ),
                                                                          )));
                                                            },
                                                            onTapFavorite: () {},
                                                            height: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height /
                                                                3,
                                                            width: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .width /
                                                                2,
                                                            product: productDetailBloc
                                                                .listProductAlsoLike[
                                                            index],
                                                            index: index,
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        _) =>
                                                                        MultiBlocProvider(
                                                                            providers: [
                                                                              BlocProvider(
                                                                                  create: (
                                                                                      _) =>
                                                                                  ProductDetailBloc(
                                                                                      InitialProductDetail())
                                                                                    ..add(
                                                                                        ProductDetailLoadEvent(
                                                                                          id: productDetailBloc
                                                                                              .listProductAlsoLike[index]
                                                                                              .id,
                                                                                          person_id: context
                                                                                              .read<
                                                                                              AccountBloc>()
                                                                                              .user!
                                                                                              .id
                                                                                              .toString(),
                                                                                        ))),
                                                                              BlocProvider
                                                                                  .value(
                                                                                value: context
                                                                                    .read<
                                                                                    CartBloc>(),
                                                                              ),
                                                                            ],
                                                                            child:
                                                                            ProductDetail(
                                                                              userId:
                                                                              context
                                                                                  .read<
                                                                                  AccountBloc>()
                                                                                  .user!
                                                                                  .id!,
                                                                              percentStar:
                                                                              productDetailBloc
                                                                                  .listProductAlsoLike[index]
                                                                                  .percentStar,
                                                                              countRating:
                                                                              productDetailBloc
                                                                                  .listProductAlsoLike[index]
                                                                                  .countRating,
                                                                              price:
                                                                              productDetailBloc
                                                                                  .listProductAlsoLike[index]
                                                                                  .price,
                                                                              productId:
                                                                              productDetailBloc
                                                                                  .listProductAlsoLike[index]
                                                                                  .id,
                                                                            ))));
                                                          });
                                                    },
                                                    childCount: productDetailBloc
                                                        .listProductAlsoLike
                                                        .length,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        if (state is LoadingProductAlsoLikeState)
                                          Positioned(
                                            bottom: 10,
                                            left: MediaQuery
                                                .of(context)
                                                .size
                                                .width /
                                                2 -
                                                15,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                spreadRadius: 1,
                                blurRadius: 2)
                          ]),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      productDetailBloc.productDetail.isLiked =
                                      !productDetailBloc
                                          .productDetail.isLiked;
                                    });

                                    if (widget.isNavigatedFromFavorite) {
                                      context.read<FavoriteBloc>().add(
                                          FavoriteTap(
                                              person_id: widget.userId.toString(),
                                              index: context
                                                  .read<FavoriteBloc>()
                                                  .index,
                                              product_id:
                                              widget.productId.toString()));
                                    } else {
                                      productDetailBloc.add(FavoriteTapEvent(
                                          person_id: widget.userId.toString(),
                                          product_id: productDetailBloc
                                              .productDetail.id
                                              .toString()));
                                    }
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Icon(
                                        productDetailBloc.productDetail.isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: productDetailBloc
                                            .productDetail.isLiked
                                            ? Colors.redAccent
                                            : Colors.black.withOpacity(0.6),
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                color: Colors.black.withOpacity(0.6),
                              ),
                              Expanded(
                                flex: 4,
                                child: InkWell(
                                  onTap: () async {
                                    if (context
                                        .read<AccountBloc>()
                                        .userId != 0) await showModalBottomSheet(
                                        context: context,
                                        builder: (_) {
                                          return BlocProvider.value(
                                            value:
                                            context.read<ProductDetailBloc>(),
                                            child: AttributesSheet(
                                              images: images,
                                              hasMuaHang: false,
                                              hasThemGioHang: true,
                                            ),
                                          );
                                        }).then((value) {
                                      if (value == "Thêm vào giỏ hàng") {
//                                      setState(() {
//                                        isAnimating = true;
//                                      });
                                        productDetailBloc.add(AddtocartEvent(
                                            person_id: widget.userId.toString(),
                                            product_id: productDetailBloc
                                                .productDetail.id
                                                .toString(),
                                            option_amount_id:
                                            productDetailBloc.optionProductId,
                                            amount: productDetailBloc.amount));

//                                      context.read<CartBloc>().add(GetCartEvent(
//                                          person_id: widget.userId.toString()));
//                                      animationController.reset();
//                                      animationController.forward();
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.black.withOpacity(0.6),
                                          size: 25,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Thêm vào giỏ hàng",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: InkWell(
                                  onTap: () async {
                                    if (context
                                        .read<AccountBloc>()
                                        .userId != 0) await showModalBottomSheet(
                                        context: context,
                                        builder: (_) {
                                          return BlocProvider.value(
                                            value: context.read<
                                                ProductDetailBloc>(),
                                            child: AttributesSheet(
                                              images: images,
                                              hasMuaHang: true,
                                              hasThemGioHang: false,
                                            ),
                                          );
                                        }).then((value) {
                                      if (value == "Mua ngay") {
                                        var optionProduct = productDetailBloc
                                            .productDetail.optionProducts
                                            .firstWhere((element) =>
                                        element.productOptionId
                                            .toString() ==
                                            productDetailBloc
                                                .optionProductId);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    BlocProvider.value(
                                                      value: context.read<
                                                          CartBloc>(),
                                                      child: BlocProvider(
                                                        create: (_) =>
                                                        AddressBloc(LoadAddress())
                                                          ..add(
                                                              InitialAddressEvent(
                                                                  userId: widget
                                                                      .userId
                                                                      .toString())),
                                                        child: BlocProvider.value(
                                                          value: context.read<
                                                              AccountBloc>(),
                                                          child: BlocProvider
                                                              .value(
                                                            value: context.read<
                                                                ProductBloc>(),
                                                            child: PaymentScreen(
                                                              userId: widget
                                                                  .userId
                                                                  .toString(),
                                                              listItems: [
                                                                CartItem.CartItem(
                                                                    cartId: 0,
                                                                    productId: productDetailBloc
                                                                        .productDetail
                                                                        .id,
                                                                    nameProduct: productDetailBloc
                                                                        .productDetail
                                                                        .name,
                                                                    amount: productDetailBloc
                                                                        .amount,
                                                                    optionProduct: CartItem
                                                                        .OptionProduct(
                                                                        productOptionId: optionProduct
                                                                            .productOptionId,
                                                                        price: CartItem
                                                                            .Price(
                                                                            value: optionProduct
                                                                                .price
                                                                                .value,
                                                                            id: optionProduct
                                                                                .price
                                                                                .id),
                                                                        quantity: CartItem
                                                                            .Quantity(
                                                                            value: optionProduct
                                                                                .quantity
                                                                                .value,
                                                                            id: optionProduct
                                                                                .quantity
                                                                                .id),
                                                                        color: CartItem
                                                                            .Color(
                                                                            value: productDetailBloc
                                                                                .options
                                                                                .length >
                                                                                1
                                                                                ? productDetailBloc
                                                                                .options[1]
                                                                                : "",
                                                                            id: 0),
                                                                        size: CartItem
                                                                            .Size(
                                                                            id: 0,
                                                                            value: productDetailBloc
                                                                                .options[0]),
                                                                        image: CartItem
                                                                            .Image(
                                                                            value: images[0],
                                                                            id: 0)))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )));
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                    BoxDecoration(color: Color(0xffF34646)),
                                    child: Center(
                                      child: Text(
                                        "Mua ngay",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isAnimating)
                      AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return Positioned(
                              right: (MediaQuery
                                  .of(context)
                                  .size
                                  .width - 60) -
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .width - 70 - 60) *
                                      animation.value,
                              top: (MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35 +
                                  180) -
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.35 +
                                      150) *
                                      animation.value,
                              child: CachedNetworkImage(
                                imageUrl: images[selectedIndex],
//                        height: 40 - animation.value * 20,
//                        width: 55 - animation.value * 30,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageBuilder: (context, image) =>
                                    CircleAvatar(
                                      backgroundImage: image,
                                      radius: 40 - 30 * animation.value,
                                    ),
                              ),
                            );
                          }),

                    //Appbar
                    Container(
                        height: 80,
                        child: AnimatedBuilder(
                          animation: _ColorAnimationController,
                          builder: (context, child) =>
                              AppBar(
                                elevation: elevation,
                                backgroundColor: _colorTween.value,
                                leadingWidth: 50,
                                leading: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _workOutTween.value),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                      color: _iconTween.value,
                                    ),
                                  ),
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                            return BlocProvider.value(
                                              value: context.read<AccountBloc>(),
                                              child: BlocProvider.value(
                                                value: context.read<
                                                    ProductBloc>(),
                                                child: BlocProvider.value(
                                                  value: context.read<CartBloc>(),
                                                  child: CartScreen(
                                                    person_id: widget.userId,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _workOutTween.value),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: _iconTween.value,
                                              size: 30,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 5,
                                            child: Container(
                                                height: 17,
                                                width: 17,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                  child: context
                                                      .read<AccountBloc>()
                                                      .userId == 0 ? Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 10),
                                                  ) : BlocBuilder<CartBloc,
                                                      CartState>(
                                                    builder: (context, state) {
                                                      if (state is InitialCart)
                                                        return Text(
                                                          "",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 10),
                                                        );
                                                      countCart = context
                                                          .read<CartBloc>()
                                                          .list_data
                                                          .length;
                                                      return Text(
                                                        countCart.toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 10),
                                                      );
                                                    },
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _workOutTween.value),
                                    child: Icon(
                                      Icons.more_horiz_outlined,
                                      color: _iconTween.value,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                        )),
                    if (state is LoadingAddtoCart)
                      Positioned(
                          top: 10,
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            color: Colors.white.withOpacity(0.7),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.redAccent,
                              ),
                            ),
                          ))
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xffF34646),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
