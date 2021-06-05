import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/blocs/RatingBloc/rating_bloc.dart';
import 'package:faiikan/blocs/RatingBloc/rating_event.dart';
import 'package:faiikan/blocs/RatingBloc/rating_state.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final images = [
  'https://img.zanado.com/media/catalog/product/cache/all/thumbnail/360x420/7b8fef0172c2eb72dd8fd366c999954c/8/_/ao_khoac_nam_xo_ngon_pa_fashion_6729.jpg',
  'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg'
];

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ScrollController scrollController = ScrollController();
  int selected = 0;
  List<String> selectedOtion = ["all", "image", "5", "4", "3", "2", "1"];

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 20)
        context.read<RatingBloc>().add(LoadMoreRatingEvent(
            product_id:
                context.read<ProductDetailBloc>().productDetail.id.toString(),
            select: selectedOtion[selected]));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(builder: (context, state) {
      if(state is InitialRatingState)
        return Container(color: Colors.white,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,),));
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Đánh giá",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Colors.black,
            ),
          ),
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
        body: Stack(
          children: [
            Column(
              children: [
                Container(
//            padding: EdgeInsets.all(20),
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 15,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Đánh giá trung bình: ",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 16,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                              child: RatingBarIndicator(
                                rating: 4.5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              calAverageStarRating(context
                                          .read<ProductDetailBloc>()
                                          .productDetail
                                          .ratingStar)
                                      .toStringAsFixed(2) +
                                  "/5.0",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          spacing: 15,
                          alignment: WrapAlignment.center,
                          runSpacing: 15,
                          direction: Axis.horizontal,
                          children: List.generate(7, (index) {
                            if (index == 0)
                              return InkWell(
                                onTap: () {
                                  if (selected != index) {
                                    selected = index;
                                    context.read<RatingBloc>().add(
                                        UpdateRatingEvent(
                                            product_id: context
                                                .read<ProductDetailBloc>()
                                                .productDetail
                                                .id
                                                .toString(),
                                            select: selectedOtion[selected]));
                                  }
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: selected == index
                                        ? Color(0xffF34040)
                                        : Color(0xffA89D9D),
                                    width: 1,
                                  )),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      Text("Tất cả"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "(" +
                                            context
                                                .read<RatingBloc>()
                                                .data
                                                .totalCount
                                                .totalAll
                                                .toString() +
                                            ")",
                                        style: TextStyle(
                                            color: selected == index
                                                ? Color(0xffF34040)
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            if (index == 1)
                              return InkWell(
                                onTap: () {
                                  if (selected != index) {
                                    selected = index;
                                    context.read<RatingBloc>().add(
                                        UpdateRatingEvent(
                                            product_id: context
                                                .read<ProductDetailBloc>()
                                                .productDetail
                                                .id
                                                .toString(),
                                            select: selectedOtion[selected]));
                                  }
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: selected == index
                                        ? Color(0xffF34040)
                                        : Color(0xffA89D9D),
                                    width: 1,
                                  )),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      Text("Có hình ảnh"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "(" +
                                              context
                                                  .read<RatingBloc>()
                                                  .data
                                                  .totalCount
                                                  .totalImage
                                                  .toString() +
                                              ")",
                                          style: TextStyle(
                                              color: selected == index
                                                  ? Color(0xffF34040)
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              );
                            if (index == 2)
                              return InkWell(
                                onTap: () {
                                  if (selected != index) {
                                    selected = index;
                                    context.read<RatingBloc>().add(
                                        UpdateRatingEvent(
                                            product_id: context
                                                .read<ProductDetailBloc>()
                                                .productDetail
                                                .id
                                                .toString(),
                                            select: selectedOtion[selected]));
                                  }
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: selected == index
                                        ? Color(0xffF34040)
                                        : Color(0xffA89D9D),
                                    width: 1,
                                  )),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                        child: RatingBarIndicator(
                                          rating: 5,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "(" +
                                              context
                                                  .read<RatingBloc>()
                                                  .data
                                                  .totalCount
                                                  .totalStar5
                                                  .toString() +
                                              ")",
                                          style: TextStyle(
                                              color: selected == index
                                                  ? Color(0xffF34040)
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              );

                            if (index == 3)
                              return InkWell(
                                onTap: () {
                                  if (selected != index) {
                                    selected = index;
                                    context.read<RatingBloc>().add(
                                        UpdateRatingEvent(
                                            product_id: context
                                                .read<ProductDetailBloc>()
                                                .productDetail
                                                .id
                                                .toString(),
                                            select: selectedOtion[selected]));
                                  };
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 85) /
                                          4,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: selected == index
                                        ? Color(0xffF34040)
                                        : Color(0xffA89D9D),
                                    width: 1,
                                  )),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                        child: RatingBarIndicator(
                                          rating: 4,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 4,
                                          itemSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "(" +
                                              context
                                                  .read<RatingBloc>()
                                                  .data
                                                  .totalCount
                                                  .totalStar4
                                                  .toString() +
                                              ")",
                                          style: TextStyle(
                                              color: selected == index
                                                  ? Color(0xffF34040)
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              );
                            if (index == 4)
                              return InkWell(
                                onTap: () {
                                  if (selected != index) {
                                    selected = index;
                                    context.read<RatingBloc>().add(
                                        UpdateRatingEvent(
                                            product_id: context
                                                .read<ProductDetailBloc>()
                                                .productDetail
                                                .id
                                                .toString(),
                                            select: selectedOtion[selected]));
                                  }
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 85) /
                                          4,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: selected == index
                                        ? Color(0xffF34040)
                                        : Color(0xffA89D9D),
                                    width: 1,
                                  )),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                        child: RatingBarIndicator(
                                          rating: 3,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 3,
                                          itemSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "(" +
                                              context
                                                  .read<RatingBloc>()
                                                  .data
                                                  .totalCount
                                                  .totalStar3
                                                  .toString() +
                                              ")",
                                          style: TextStyle(
                                              color: selected == index
                                                  ? Color(0xffF34040)
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              );
                            if (index == 5)
                              return InkWell(
                                onTap: () {
                                  if (selected != index) {
                                    selected = index;
                                    context.read<RatingBloc>().add(
                                        UpdateRatingEvent(
                                            product_id: context
                                                .read<ProductDetailBloc>()
                                                .productDetail
                                                .id
                                                .toString(),
                                            select: selectedOtion[selected]));
                                  }
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 85) /
                                          4,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: selected == index
                                        ? Color(0xffF34040)
                                        : Color(0xffA89D9D),
                                    width: 1,
                                  )),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                        child: RatingBarIndicator(
                                          rating: 2,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 2,
                                          itemSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "(" +
                                              context
                                                  .read<RatingBloc>()
                                                  .data
                                                  .totalCount
                                                  .totalStar2
                                                  .toString() +
                                              ")",
                                          style: TextStyle(
                                              color: selected == index
                                                  ? Color(0xffF34040)
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              );
                            if (index == 6)
                              return InkWell(
                                onTap: () {
                                  if (selected != index) {
                                    selected = index;
                                    context.read<RatingBloc>().add(
                                        UpdateRatingEvent(
                                            product_id: context
                                                .read<ProductDetailBloc>()
                                                .productDetail
                                                .id
                                                .toString(),
                                            select: selectedOtion[selected]));
                                  }
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 85) /
                                          4,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: selected == index
                                        ? Color(0xffF34040)
                                        : Color(0xffA89D9D),
                                    width: 1,
                                  )),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                        child: RatingBarIndicator(
                                          rating: 1,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 1,
                                          itemSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "(" +
                                              context
                                                  .read<RatingBloc>()
                                                  .data
                                                  .totalCount
                                                  .totalStar1
                                                  .toString() +
                                              ")",
                                          style: TextStyle(
                                              color: selected == index
                                                  ? Color(0xffF34040)
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              );

                            return Container();
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 10,
                  color: Color(0xffE7E7E7),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount:
                            context.read<RatingBloc>().data.listrating.length,
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  context.read<RatingBloc>().data.listrating[index].imageAvatar),
                                              radius: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              context.read<RatingBloc>().data.listrating[index].userName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 35,
                                            ),
                                            SizedBox(
                                              height: 15,
                                              child: RatingBarIndicator(
                                                rating:  context.read<RatingBloc>().data.listrating[index].star.toDouble(),
                                                itemBuilder: (context, index) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Text(
                                          context.read<RatingBloc>().data.listrating[index].comment,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              letterSpacing: 0.5,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Text(
                                          context.read<RatingBloc>().data.listrating[index].timeUpdated +" | Phân loại: " + (context.read<RatingBloc>().data.listrating[index].size==null? "" : context.read<RatingBloc>().data.listrating[index].size!) +", "+ (context.read<RatingBloc>().data.listrating[index].color==null? "" : context.read<RatingBloc>().data.listrating[index].color!),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              letterSpacing: 0.5,
                                              color: Colors.black.withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                 if( context.read<RatingBloc>().data.listrating[index].imageRating.length>0)   Container(
                                        margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
                                        height: 100,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:  context.read<RatingBloc>().data.listrating[index].imageRating.length,
                                            itemBuilder: (context, i) {
                                              String image =  context.read<RatingBloc>().data.listrating[index].imageRating[i];
                                              return Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1,
                                                        color:
                                                        Colors.black.withOpacity(0.2),
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
                                                    errorWidget: (context, url, error) =>
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
                                    SizedBox(height: 10,),
                                    Container(
                                      height: 1,
                                      color: Colors.black12,
                                    ),

                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 30,
                                  right: 20,
                                  child: Icon(
                                    Icons.thumb_up_alt,
                                    color: Colors.black.withOpacity(0.5),
                                    size: 25,
                                  ))
                            ],
                          );
                        }),
                  ),
                ),

              ],
            ),
            if (state is LoadRating)
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                ),
              )
          ],
        ),
      );
    });
  }
}

double calAverageStarRating(RatingStar s) {
  if(s.star1 + s.star2 + s.star3 + s.star4 + s.star5==0)
    return 0;
  return (s.star1 + s.star2 * 2 + s.star3 * 3 + s.star4 * 4 + s.star5 * 5) /
      (s.star1 + s.star2 + s.star3 + s.star4 + s.star5);
}
