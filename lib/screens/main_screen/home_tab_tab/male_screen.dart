import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/blocs/hot_search_bloc/hot_search_bloc.dart';
import 'package:faiikan/blocs/hot_search_bloc/hot_search_event.dart';
import 'package:faiikan/blocs/hot_search_bloc/hot_search_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/blocs/search_bloc/search_bloc.dart';
import 'package:faiikan/blocs/search_bloc/search_event.dart';
import 'package:faiikan/blocs/search_bloc/search_state.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_bloc.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_event.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_state.dart';
import 'package:faiikan/models/category.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/screens/product_screen/ProductWithCatLv3_Screen.dart';
import 'package:faiikan/screens/search_screen/search_screen.dart';
import 'package:faiikan/screens/similar_product_screen/similar_product_screen.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:faiikan/models/category.dart' as Cate;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../category_tab.dart';

List<String> imagesFlashSale = [
  "https://assets.adidas.com/images/w_600,f_auto,q_auto/e714edee57fa45a2b102acaf010e276d_9366/Stan_Smith_Shoes_White_GZ3098_01_standard.jpg",
  "https://media3.scdn.vn/img3/2019/4_11/RNYPwV_simg_de2fe0_500x500_maxb.jpg",
  "https://media3.scdn.vn/img4/2021/04_27/BBxkmtiq7Qj4jlR9BT4n_simg_de2fe0_500x500_maxb.jpg",
  "https://media3.scdn.vn/img3/2019/11_22/EeqVb7_simg_de2fe0_500x500_maxb.jpg",
  "https://media3.scdn.vn/img4/2020/08_28/0Flhy94WecKP5ULHzB9G_simg_de2fe0_500x500_maxb.png",
];
List<int> priceFlashSale = [
  (200 + Random().nextInt(100)),
  (200 + Random().nextInt(100)),
  (200 + Random().nextInt(100)),
  (200 + Random().nextInt(100)),
  (200 + Random().nextInt(100)),
];
List<int> soldAmountFlashSale = [
  (200 + Random().nextInt(1000)),
  (200 + Random().nextInt(1000)),
  (200 + Random().nextInt(1000)),
  (200 + Random().nextInt(1000)),
  (200 + Random().nextInt(1000))
];
List<int> promotionFlashSale = [
  (30 + Random().nextInt(3) * 10),
  (30 + Random().nextInt(3) * 10),
  (30 + Random().nextInt(3) * 10),
  (30 + Random().nextInt(3) * 10),
  (30 + Random().nextInt(3) * 10),
];

final items = [
  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/mens-clothing-store-design-template-eae000def39b8be63aed3b10868f04a6.jpg?ts=1566567308",
  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/mens-clothing-sale-portrait-flyer-template-1627835dd392414eb308cf84fde379a1.jpg?ts=1561727156",
  "https://www.designbold.com/academy/wp-content/uploads/2016/10/instagram-fashion-sale-10.png",
  "https://static.vecteezy.com/system/resources/previews/000/694/272/non_2x/fashion-sale-grunge-social-media-poster-vector.jpg",
];

class MaleScreen extends StatefulWidget {
  @override
  _MaleScreenState createState() => _MaleScreenState();
}

class _MaleScreenState extends State<MaleScreen> {
  int _current = 0;
//  int time = 23 * 3600;
//  late Timer _timer;
  CarouselController carouselController = CarouselController();
  late ProductBloc productBloc;
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  bool flag = true;

  @override
  void initState() {
//    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//      setState(() {
//        if (time > 0) time--;
//      });
//    });

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
          _scrollController.position.maxScrollExtent - 10) {
        context.read<ProductBloc>().add(ProductGetMoreDataByCategoryCodeEvent(filter: "", catId: 16));
      }
    });
  }

  @override
  void dispose() {
//    _timer.cancel();
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
//            Container(
//              padding: EdgeInsets.symmetric(
//                vertical: 12,
//                horizontal: 8,
//              ),
//              color: Colors.white,
//              child: Container(
//                height: MediaQuery.of(context).size.height / 4,
//                decoration: BoxDecoration(
//                  color: Colors.black.withOpacity(0.05),
//                  borderRadius: BorderRadius.circular(10),
//                ),
//                child: Column(
//                  children: [
//                    Padding(
//                      padding: const EdgeInsets.symmetric(
//                        vertical: 5,
//                        horizontal: 10,
//                      ),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: [
//                          Row(
//                            children: [
//                              Image.asset("assets/images/flashsale.png"),
//                              Text(
//                                "FLASH SALE",
//                                style: TextStyle(
//                                    fontSize: 18,
//                                    color: Color(0xffF34646),
//                                    letterSpacing: 0.5,
//                                    fontWeight: FontWeight.w600,
//                                    fontStyle: FontStyle.italic),
//                              ),
//                            ],
//                          ),
//                          Row(
//                            children: [
//                              Row(
//                                children: [
//                                  Text(
//                                    ":",
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 10),
//                                  ),
//                                  Container(
//                                    padding: EdgeInsets.symmetric(
//                                        vertical: 2, horizontal: 3),
//                                    decoration: BoxDecoration(
//                                        color: Colors.black,
//                                        borderRadius: BorderRadius.circular(1)),
//                                    child: Text(
//                                      (time ~/ 3600).toString(),
//                                      style: TextStyle(
//                                          color: Colors.white, fontSize: 10),
//                                    ),
//                                  ),
//                                  Text(
//                                    ":",
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 10),
//                                  ),
//                                  Container(
//                                    padding: EdgeInsets.symmetric(
//                                        vertical: 2, horizontal: 3),
//                                    decoration: BoxDecoration(
//                                        color: Colors.black,
//                                        borderRadius: BorderRadius.circular(1)),
//                                    child: Text(
//                                      (time % 3600 ~/ 60) >= 10
//                                          ? (time % 3600 ~/ 60).toString()
//                                          : "0" +
//                                          (time % 3600 ~/ 60).toString(),
//                                      style: TextStyle(
//                                          color: Colors.white, fontSize: 10),
//                                    ),
//                                  ),
//                                  Text(
//                                    ":",
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 10),
//                                  ),
//                                  Container(
//                                    padding: EdgeInsets.symmetric(
//                                        vertical: 2, horizontal: 3),
//                                    decoration: BoxDecoration(
//                                        color: Colors.black,
//                                        borderRadius: BorderRadius.circular(1)),
//                                    child: Text(
//                                      (time % 60) >= 10
//                                          ? (time % 60).toString()
//                                          : "0" + (time % 60).toString(),
//                                      style: TextStyle(
//                                          color: Colors.white, fontSize: 10),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    width: 5,
//                                  ),
//                                  Icon(
//                                    Icons.arrow_forward_ios_sharp,
//                                    color: Color(0xffF8BD00),
//                                    size: 15,
//                                  )
//                                ],
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      height: MediaQuery.of(context).size.height / 4 - 40,
//                      child: ListView.builder(
//                          padding: EdgeInsets.only(left: 10),
//                          scrollDirection: Axis.horizontal,
//                          itemCount: 5,
//                          itemBuilder: (context, index) {
//                            return InkWell(
//                              onTap: () {
////                                Navigator.of(context).push(PageRouteBuilder(
////                                    transitionDuration:
////                                        Duration(milliseconds: 2000),
////                                    pageBuilder: (context, animation, _) {
////                                      return FadeTransition(
////                                        opacity: animation,
////                                        child: ProductDetail(
////                                          percentStar: productBloc
////                                              .listdataByCategory[index].percentStar,
////                                          countRating: productBloc
////                                              .listdataByCategory[index].countRating,
////                                          price:
////                                              productBloc.listdataByCategory[index].price,
////                                          productId: 1,
////                                        ),
////                                      );
////    }));
//                              },
//                              child: Container(
//                                margin: EdgeInsets.only(
//                                  right: 20,
//                                ),
//                                width: MediaQuery.of(context).size.width / 4,
//                                child: Column(
//                                  children: [
//                                    Expanded(
//                                      flex: 2,
//                                      child: Stack(
//                                        children: [
//                                          Container(
//                                            margin: EdgeInsets.only(top: 2),
//                                            child: CachedNetworkImage(
//                                              imageUrl: imagesFlashSale[index],
//                                              fit: BoxFit.fill,
//                                              placeholder: (context, url) => Center(
//                                                  child: Center(
//                                                      child:
//                                                      CircularProgressIndicator())),
//                                              errorWidget:
//                                                  (context, url, error) =>
//                                                  Icon(Icons.error),
//                                            ),
//                                            decoration: BoxDecoration(
//                                              boxShadow: [
//                                                BoxShadow(
//                                                  color: Colors.purple
//                                                      .withOpacity(0.5),
//                                                  spreadRadius: 1,
//                                                  blurRadius: 2,
//                                                  offset: Offset(0,
//                                                      0), // changes position of shadow
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                          Positioned(
//                                            child: Container(
//                                              height: 20,
//                                              width: 30,
//                                              decoration: BoxDecoration(
//                                                  color: Color(0xffF05A5A),
//                                                  borderRadius:
//                                                  BorderRadius.only(
//                                                      bottomRight:
//                                                      Radius.circular(
//                                                          20),
//                                                      topLeft:
//                                                      Radius.circular(
//                                                          5))),
//                                              child: Center(
//                                                child: Text(
//                                                  promotionFlashSale[index]
//                                                      .toString() +
//                                                      "%",
//                                                  style: TextStyle(
//                                                      color: Colors.white,
//                                                      fontSize: 8),
//                                                ),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      height: 5,
//                                    ),
//                                    Expanded(
//                                        flex: 1,
//                                        child: Column(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment.spaceEvenly,
//                                          children: [
//                                            Text(
//                                              priceFlashSale[index].toString() +
//                                                  ".000đ",
//                                              style: TextStyle(
//                                                fontSize: 16,
//                                                fontWeight: FontWeight.w500,
//                                                letterSpacing: 0.5,
//                                                color: Colors.black,
//                                              ),
//                                            ),
//                                            LinearPercentIndicator(
//                                              center: Text(
//                                                soldAmountFlashSale[index]
//                                                    .toString() +
//                                                    " đã bán",
//                                                style: TextStyle(
//                                                    fontSize: 10,
//                                                    color: Colors.white),
//                                              ),
//                                              padding: EdgeInsets.symmetric(
//                                                  vertical: 2, horizontal: 5),
//                                              percent: 0.6,
//                                              lineHeight: 18,
//                                              backgroundColor:
//                                              Color(0xffF9AEAE),
//                                              progressColor: Color(0xffFF6161),
//                                            )
//                                          ],
//                                        ))
//                                  ],
//                                ),
//                              ),
//                            );
//                          }),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 5,
//            ),
//            Container(
//              color: Colors.white,
//              padding: EdgeInsets.only(left: 10, right: 5),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    "DANH MỤC",
//                    style: TextStyle(
//                      fontSize: 18,
//                      color: Colors.black.withOpacity(0.8),
//                      fontWeight: FontWeight.w700,
//                      letterSpacing: 0.5,
//                    ),
//                  ),
//                  GestureDetector(
//                    child: Padding(
//                      padding: EdgeInsets.only(top: 5),
//                      child: Row(
//                        children: [
//                          Text(
//                            "Xem tất cả",
//                            style: TextStyle(
//                              color: Color(0xff3A1DEC),
//                              fontSize: 14,
//                              fontWeight: FontWeight.w400,
//                              letterSpacing: 0.5,
//                            ),
//                            textAlign: TextAlign.center,
//                          ),
//                          Icon(
//                            Icons.arrow_forward_ios_sharp,
//                            color: Color(0xff3A1DEC),
//                            size: 15,
//                          ),
//                          SizedBox(
//                            width: 5,
//                          ),
//                        ],
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (_) => BlocProvider.value(
//                                  value: context.read<CategoryBloc>(),
//                                  child: BlocProvider.value(
//                                    value: context.read<CartBloc>(),
//                                    child: CategoryScreen(
//                                      userId:
//                                      context.read<AccountBloc>().user.id!,
//                                    ),
//                                  ))));
//                    },
//                  )
//                ],
//              ),
//            ),
            Container(
                height: 10,
                width: MediaQuery.of(context).size.width,
                color: Colors.white),
            Row(
              children: <Widget>[
                BlocBuilder<CategoryBloc,CategoryState>(
                  builder: (context,state) {
                    if(state is LoadingCategory)
                      return Container(
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
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey,
                                              highlightColor: Colors.grey
                                                  .withOpacity(0.5),
                                              child: Container(
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
                                                    )),
                                              ),
                                            ),
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey,
                                              highlightColor: Colors.grey
                                                  .withOpacity(0.5),
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Loading....",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                     ),
                                );
                              }));
                  return Container(
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
                                                  imageUrl: category.icon != ""
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              BlocProvider<ProductBloc>(
                                                create: (_) {
                                                  return ProductBloc(
                                                    InitialProductState(
                                                      data: [],
                                                      error: "",
                                                      sortBy: 0,
                                                    ),
                                                  )..add(ProductByCategoryCodeEvent(
                                                      categoryId:
                                                      category.id.toString(),
                                                      filter: "popular"));
                                                },
                                                child: BlocProvider.value(
                                                    value: context.read<CartBloc>(),
                                                    child: ProductWithSubCat_Screen(
                                                        userId: context
                                                            .read<AccountBloc>()
                                                            .user!
                                                            .id!,
                                                        title: category.name,
                                                        category: category)),
                                              ),
                                        ));
                                  }),
                            );
                          }));}),
              ],
            ),
            SizedBox(
              height: 5,
            ),
//            Container(
//              padding: EdgeInsets.all(10),
//              decoration: BoxDecoration(color: Colors.white),
//              child: Column(
//                children: [
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Text(
//                        "TÌM KIẾM PHỔ BIẾN",
//                        style: TextStyle(
//                          color: Colors.black87,
//                          fontSize: 18,
//                          letterSpacing: 0.5,
//                          fontWeight: FontWeight.w700,
//                        ),
//                      ),
//                      InkWell(
//                        onTap: () {
//                          context
//                              .read<HotSearchBloc>()
//                              .add(LoadMoreHotSearchEvent());
//                        },
//                        child: Row(
//                          children: [
//                            Icon(
//                              Icons.refresh_rounded,
//                              color: Color(0xff0C73D2),
//                              size: 25,
//                            ),
//                            Text(
//                              "Đổi",
//                              style: TextStyle(
//                                color: Color(0xff0C73D2),
//                                fontSize: 16,
//                                letterSpacing: 0.5,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                  BlocBuilder<HotSearchBloc, HotSearchState>(
//                    builder: (context, state) {
//                      if (state is LoadHotSearch)
//                        return Container(
//                          height: MediaQuery.of(context).size.height / 4,
//                          child: GridView.count(
//                            scrollDirection: Axis.vertical,
//                            mainAxisSpacing: 10,
//                            physics: NeverScrollableScrollPhysics(),
//                            crossAxisSpacing: 10,
//                            childAspectRatio: 2,
//                            crossAxisCount: 2,
//                            children: List.generate(4, (index) {
//                              return InkWell(
//                                onTap: () {},
//                                child: Container(
//                                  margin: EdgeInsets.all(2),
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    border: Border.all(
//                                      color: Colors.black12,
//                                      width: 1,
//                                    ),
//                                    boxShadow: [
//                                      BoxShadow(
//                                        color: Colors.black.withOpacity(0.1),
//                                        spreadRadius: 1,
//                                        blurRadius: 2,
//                                        offset: Offset(
//                                            0, 0), // changes position of shadow
//                                      ),
//                                    ],
//                                  ),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: [
//                                      Expanded(
//                                        flex: 1,
//                                        child: Container(
//                                            height: (MediaQuery.of(context)
//                                                .size
//                                                .height /
//                                                4 -
//                                                20) /
//                                                2,
//                                            child: Center(
//                                              child: Shimmer.fromColors(
//                                                baseColor: Colors.grey,
//                                                highlightColor: Colors.grey
//                                                    .withOpacity(0.5),
//                                                child: Text(
//                                                  "Loading...",
//                                                  style: TextStyle(
//                                                    color: Colors.black,
//                                                    fontSize: 14,
//                                                    letterSpacing: 0.5,
//                                                  ),
//                                                ),
//                                              ),
//                                            )),
//                                      ),
//                                      Expanded(
//                                        flex: 1,
//                                        child: Shimmer.fromColors(
//                                          baseColor: Colors.grey,
//                                          highlightColor:
//                                          Colors.grey.withOpacity(0.5),
//                                          child: Container(
//                                            height: (MediaQuery.of(context)
//                                                .size
//                                                .height /
//                                                4 -
//                                                20) /
//                                                2,
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              );
//                            }),
//                          ),
//                        );
//                      return Container(
//                        height: MediaQuery.of(context).size.height / 4,
//                        child: GridView.count(
//                          scrollDirection: Axis.vertical,
//                          mainAxisSpacing: 10,
//                          physics: NeverScrollableScrollPhysics(),
//                          crossAxisSpacing: 10,
//                          childAspectRatio: 2,
//                          crossAxisCount: 2,
//                          children: List.generate(4, (index) {
//                            return InkWell(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (_) => BlocProvider(
//                                          create: (_) => SearchBloc(
//                                              InitialSearchState())
//                                            ..add(SearchTextEvent(
//                                                text: context
//                                                    .read<HotSearchBloc>()
//                                                    .listHotSearch[index]
//                                                    .keyword,
//                                                userId: context
//                                                    .read<AccountBloc>()
//                                                    .user
//                                                    .id!
//                                                    .toString())),
//                                          child: BlocProvider.value(
//                                            value: context.read<CartBloc>(),
//                                            child: SearchScreen(
//                                              userId: context
//                                                  .read<AccountBloc>()
//                                                  .user
//                                                  .id!,
//                                            ),
//                                          ),
//                                        )));
//                              },
//                              child: Container(
//                                margin: EdgeInsets.all(2),
//                                decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  border: Border.all(
//                                    color: Colors.black12,
//                                    width: 1,
//                                  ),
//                                  boxShadow: [
//                                    BoxShadow(
//                                      color: Colors.black.withOpacity(0.1),
//                                      spreadRadius: 1,
//                                      blurRadius: 2,
//                                      offset: Offset(
//                                          0, 0), // changes position of shadow
//                                    ),
//                                  ],
//                                ),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: [
//                                    Expanded(
//                                      flex: 1,
//                                      child: Container(
//                                          height: (MediaQuery.of(context)
//                                              .size
//                                              .height /
//                                              4 -
//                                              20) /
//                                              2,
//                                          child: Center(
//                                            child: Text(
//                                              context
//                                                  .read<HotSearchBloc>()
//                                                  .listHotSearch[index]
//                                                  .keyword,
//                                              style: TextStyle(
//                                                color: Colors.black,
//                                                fontSize: 14,
//                                                letterSpacing: 0.5,
//                                              ),
//                                            ),
//                                          )),
//                                    ),
//                                    Expanded(
//                                      flex: 1,
//                                      child: Container(
//                                        height: (MediaQuery.of(context)
//                                            .size
//                                            .height /
//                                            4 -
//                                            20) /
//                                            2,
//                                        child: CachedNetworkImage(
//                                          imageUrl: context
//                                              .read<HotSearchBloc>()
//                                              .listHotSearch[index]
//                                              .linkImage,
//                                          placeholder: (context, url) => Center(
//                                              child:
//                                              CircularProgressIndicator()),
//                                          errorWidget: (context, url, error) =>
//                                              Icon(Icons.error),
//                                          fit: BoxFit.fill,
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            );
//                          }),
//                        ),
//                      );
//                    },
//                  ),
//                ],
//              ),
//            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  color: Colors.white,
                  child: Text(
                    "Danh sách sản phẩm",
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
//            SizedBox(
//              height: 5,
//            ),
//            Container(
//              height: MediaQuery.of(context).size.height / 4 < 200
//                  ? 200
//                  : MediaQuery.of(context).size.height / 4,
//              width: MediaQuery.of(context).size.width,
//              child: ListView.builder(
//                  scrollDirection: Axis.horizontal,
//                  itemCount: productBloc.listRecommendTopRating.length,
//                  itemBuilder: (context, index) {
//                    return GestureDetector(
//                        child: Container(
//                          margin: EdgeInsets.only(right: 5),
//                          child: ProductCard(
//                            onTapFavorite: () {},
//                            height: MediaQuery.of(context).size.height / 4 < 200
//                                ? 200
//                                : MediaQuery.of(context).size.height / 4,
//                            width: MediaQuery.of(context).size.width / 3,
//                            product: productBloc.listRecommendTopRating[index],
//                            index: index,
//                          ),
//                        ),
//                        onTap: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (_) => MultiBlocProvider(
//                                          providers: [
//                                            BlocProvider(
//                                                create: (_) =>
//                                                    ProductDetailBloc(LoadingProductDetail())
//                                                  ..add(ProductDetailLoadEvent(
//                                                    id: productBloc.listRecommendTopRating[index].id,
//                                                    person_id: context
//                                                        .read<AccountBloc>()
//                                                        .user
//                                                        .id
//                                                        .toString(),
//                                                  ))),
//                                            BlocProvider.value(
//                                              value: context.read<CartBloc>(),
//                                            ),
//                                          ],
//                                          child: ProductDetail(
//                                            userId: context
//                                                .read<AccountBloc>()
//                                                .user
//                                                .id!,
//                                            percentStar: productBloc
//                                                .listRecommendTopRating[index]
//                                                .percentStar,
//                                            countRating: productBloc
//                                                .listRecommendTopRating[index]
//                                                .countRating,
//                                            price: productBloc
//                                                .listRecommendTopRating[index]
//                                                .price,
//                                            productId: productBloc
//                                                .listRecommendTopRating[index]
//                                                .id,
//                                          ))));
//                        });
//                  }),
//            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Color(0xffE7E7E7),
                              width: 5,
                            ),
                            bottom: BorderSide(
                              color: Color(0xffE7E7E7),
                              width: 5,
                            ))),
                    child: Row(
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
                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
                  BlocBuilder<ProductBloc, ProductsState>(
                    builder: (context, state) {
                      if(state is Loading)
                        return Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 5, vertical: 5),
                          color: Color(0xffE7E7E7),
                          height: MediaQuery.of(context).size.height - 300,
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
                                        .width / 2 )
                                        /
                                        (MediaQuery.of(context).size.height /
                                            3 ),
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    //childAspectRatio: AppSizes.tile_width / AppSizes.tile_height,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height /
                                              3,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              2,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                    childCount: 10,
                                  ),
                                ),
                              ]),
                        );
                      return Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 5, vertical: 5),
                        color: Color(0xffE7E7E7),
                        height: MediaQuery.of(context).size.height - 300,
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
                                      22 / 5) /
                                      (MediaQuery.of(context).size.height /
                                          3 -
                                          2),
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  //childAspectRatio: AppSizes.tile_width / AppSizes.tile_height,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        child: ProductCard(
                                          onTapSimilar: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (_) => BlocProvider
                                                        .value(
                                                      value: context
                                                          .read<
                                                          CartBloc>(),
                                                      child:
                                                      BlocProvider(
                                                        create: (_) => SimilarProductBloc(
                                                            InitialSimilarProductState())
                                                          ..add(InitiateSimilarProductEvent(
                                                              productId: productBloc
                                                                  .listdataByCategory[index]
                                                                  .id
                                                                  .toString())),
                                                        child: SimilarProductScreen(
                                                            interactingProduct:
                                                            productBloc.listdataByCategory[
                                                            index],
                                                            userId: context
                                                                .read<AccountBloc>()
                                                                .user!
                                                                .id!),
                                                      ),
                                                    )));
                                          },
                                          onTapFavorite: () {},
                                          height: MediaQuery.of(context)
                                              .size
                                              .height /
                                              3,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              2,
                                          product:
                                          productBloc.listdataByCategory[index],
                                          index: index,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                                create: (_) =>
                                                                ProductDetailBloc(
                                                                    InitialProductDetail())
                                                                  ..add(
                                                                      ProductDetailLoadEvent(
                                                                        id: productBloc.listdataByCategory[index].id,
                                                                        person_id:
                                                                        context.read<AccountBloc>().user!.id.toString(),
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
                                                            userId: context
                                                                .read<
                                                                AccountBloc>()
                                                                .user!
                                                                .id!,
                                                            percentStar: productBloc
                                                                .listdataByCategory[
                                                            index]
                                                                .percentStar,
                                                            countRating: productBloc
                                                                .listdataByCategory[
                                                            index]
                                                                .countRating,
                                                            price: productBloc
                                                                .listdataByCategory[
                                                            index]
                                                                .price,
                                                            productId:
                                                            productBloc
                                                                .listdataByCategory[
                                                            index]
                                                                .id,
                                                          ))));
                                        });
                                  },
                                  childCount: productBloc.listdataByCategory.length,
                                ),
                              ),
                            ]),
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
