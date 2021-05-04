import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/screens/cart_screen/cart_screen.dart';
import 'package:faiikan/screens/main_screen/home_tab.dart';
import 'package:faiikan/screens/main_screen/home_tab_tab/for_you_tab.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/attribute_sheet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

final images = [
  'https://img.zanado.com/media/catalog/product/cache/all/thumbnail/360x420/7b8fef0172c2eb72dd8fd366c999954c/8/_/ao_khoac_nam_xo_ngon_pa_fashion_6729.jpg',
  'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg'
];

class ProductDetail extends StatefulWidget {
  final int productId;

  const ProductDetail({required this.productId});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  bool isExpanded = false;
  int selectedIndex = 0;
  late AnimationController animationController;
  late Animation<double> animation;
  bool isAnimating = false;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            if (animation.status == AnimationStatus.completed) {
              setState(() {
                isAnimating = false;
              });
            }
          });
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CarouselSlider(
                              items: List.generate(images.length, (index) {
                                return CachedNetworkImage(
                                  imageUrl: images[index],
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
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
                                height: MediaQuery.of(context).size.height / 3,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 15,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)),
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
                            Positioned(
                                top: 30,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return BlocProvider(
                                                  create: (BuildContext
                                                          context) =>
                                                      CartBloc(Initial(
                                                          data: [],
                                                          discount: 0,
                                                          totalPrice: 0))
                                                        ..add(GetCartEvent(
                                                            person_id:
                                                                "person_id")),
                                                  child: CartScreen(
                                                    person_id: "1",
                                                  ),
                                                );
                                              }));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: 25,
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
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                            child: Icon(
                                              Icons.more_horiz_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.black26,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Color(0xffffffff)),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: "vi")
                                                  .format(229000)
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color(0xffF65151),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        1 != 0
                                            ? Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                height: 20,
                                                child: Center(
                                                    child: Text(
                                                  NumberFormat.simpleCurrency(
                                                          locale: "vi")
                                                      .format(302000)
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationThickness: 2,
                                                      decorationColor:
                                                          Colors.black54,
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
                                  40 != 0
                                      ? Container(
                                          child: Center(
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffF9CF3B)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 5),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "40%",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xffF65151)),
                                                    ),
                                                    Text(
                                                      "GIẢM",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          letterSpacing: 0.5),
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
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      child: Text(
                                        "Áo khoác nam xỏ ngón",
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
                                      rating: 4.8,
                                      itemBuilder: (context, index) => Icon(
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
                                      "4.8",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
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
                                    "Đã bán 95",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
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
                                height: 60,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.all(10),
                                    itemCount: images.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == images.length)
                                        return InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (_) {
                                                  return AttributesSheet(
                                                    images: images,
                                                    isSheet: true,
                                                  );
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffC4C4C4)
                                                    .withOpacity(0.3),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                  width: 1,
                                                )),
                                            height: 40,
                                            width: 55,
                                            child: Center(
                                              child: Icon(
                                                Icons.more_horiz_outlined,
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
                                              imageUrl: images[index],
                                              height: 40,
                                              width: 55,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ],
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            "Chi tiết sản phẩm",
                            style: TextStyle(
                              fontSize: 13,
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
                              AnimatedCrossFade(
                                firstChild: Text(
                                  "shortDescription",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                secondChild: Html(
                                  data:
                                      '''<div class="product-attributes"><div class="title">Thông số kĩ thuật</div><div class="product-attribute"><div class="attribute-title">Mã SP</div><div class="attribute-text" style="color: #dc0309; font-weight: bold;">SID30638</div></div><div class="product-attribute"><div class="attribute-title">Màu Sắc</div><div class="attribute-text"><a href="/ao-khoac-ni-nam-145.html?color=68">Xám</a>, <a href="/ao-khoac-ni-nam-145.html?color=32">Xanh đen</a></div></div><div class="product-attribute"><div class="attribute-title">Kích Thước</div><div class="attribute-text"><a href="/ao-khoac-ni-nam-145.html?size=69">L</a></div></div><div class="product-attribute"><div class="attribute-title">Chất liệu</div><div class="attribute-text"><a href="/ao-khoac-ni-nam-145.html?chatlieu=633">Nỉ</a></div></div><div class="product-attribute"><div class="attribute-title">Kiểu dáng</div><div class="attribute-text"><a href="/ao-khoac-ni-nam-145.html?kieudang=676">Có nón</a>, <a href="/ao-khoac-ni-nam-145.html?kieudang=649">Tay dài</a>, <a href="/ao-khoac-ni-nam-145.html?kieudang=859">Xỏ ngón</a></div></div><div class="product-attribute"><div class="attribute-title">Mục đích SD</div><div class="attribute-text"><a href="/ao-khoac-ni-nam-145.html?mucdichsudung=777">Bảo vệ da</a>, <a href="/ao-khoac-ni-nam-145.html?mucdichsudung=659">Du lịch</a>, <a href="/ao-khoac-ni-nam-145.html?mucdichsudung=666">Đi chơi</a>, <a href="/ao-khoac-ni-nam-145.html?mucdichsudung=667">Đi học</a></div></div><div class="product-attribute"><div class="attribute-title">Mùa phù hợp</div><div class="attribute-text"><a href="/ao-khoac-ni-nam-145.html?muaphuhop=1038">Thu Đông</a>, <a href="/ao-khoac-ni-nam-145.html?muaphuhop=1039">Xuân Hè</a></div></div><div class="product-attribute"><div class="attribute-title">Tình trạng</div><div class="attribute-text" style="color:#dc0309;">CÒN ÍT HÀNG</div></div></div>''',
                                ),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: kThemeAnimationDuration,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      isExpanded ? "<Thu gọn>" : "<Xem thêm>",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isExpanded
                                            ? isExpanded = false
                                            : isExpanded = true;
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
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Đánh giá ",
                                style: TextStyle(
                                  fontSize: 18,
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
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://i.pinimg.com/236x/b5/0e/31/b50e311008e481dafae4be71f44f5d1f.jpg"),
                                        radius: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Nguyễn Thị A',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: RatingBarIndicator(
                                      rating: 4.8,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
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
                                  Text(
                                      "Sản Phẩm chất lượng, đúng mô tả."),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                                  height: 100,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: images.length,
                                      itemBuilder: (context, index) {
                                        String image = images[index];
                                        return Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 1,
                                                      spreadRadius: 1,
                                                      offset: Offset(0, 0))
                                                ]),
                                            margin: EdgeInsets.only(right: 15),
                                            child: CachedNetworkImage(
                                              imageUrl: image,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              height: 100,
                                              colorBlendMode: BlendMode.darken,
                                            ));
                                      })),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black.withOpacity(0.6),
                              size: 35,
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
                            await showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return AttributesSheet(
                                    images: images,
                                    isSheet: false,
                                  );
                                }).then((value) {
                              if (value == "Thêm vào giỏ hàng") {
                                setState(() {
                                  isAnimating = true;
                                });
                                animationController.reset();
                                animationController.forward();
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
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return AttributesSheet(
                                    images: images,
                                    isSheet: true,
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xffF34646)),
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
                      right: (MediaQuery.of(context).size.width - 60) -
                          (MediaQuery.of(context).size.width - 130) *
                              animation.value,
                      top: (MediaQuery.of(context).size.height / 3 + 180) -
                          (MediaQuery.of(context).size.height / 3 + 150) *
                              animation.value,
                      child: CachedNetworkImage(
                        imageUrl: images[selectedIndex],
//                        height: 40 - animation.value * 20,
//                        width: 55 - animation.value * 30,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 40 - 30 * animation.value,
                        ),
                      ),
                    );
                  }),
          ],
        ),
      ),
    );
  }
}