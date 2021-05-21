import 'package:faiikan/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  final double height;
  final double width;
  bool hasLike;
  final VoidCallback onTapFavorite;
  bool liked;
  ProductCard({
    required this.product,
    required this.index,
    required this.height,
    required this.width,
    this.hasLike = false,
    this.liked=false,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
//      margin: EdgeInsets.only(
//          left: 3, bottom: 3, right: 3,top: 3),
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.colorBurn,
        color: Colors.white.withOpacity(0),
//        borderRadius: BorderRadius.circular(8),
//        boxShadow: [
//          BoxShadow(
//            color: Colors.black.withOpacity(0.3),
//            spreadRadius: 1,
//            blurRadius: 2,
//            offset: Offset(0, 0),
//          ),
//        ],
      ),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              ClipRRect(
//                  borderRadius: BorderRadius.only(
//                      topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                  child: Image.network(
                product.imgUrl != null
                    ? product.imgUrl
                    : "https://cdn.tgdd.vn/comment/34134321/58595582_1405843519557852_4325264661025914880_n-20190424085228.jpg",
                fit: BoxFit.fill,
                width: width == null
                    ? MediaQuery.of(context).size.width / 2
                    : width,
                height: height == null
                    ? MediaQuery.of(context).size.height / 3 - 80
                    : height - 140,
                colorBlendMode: BlendMode.darken,
              )),
              Container(
                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.only(
//                      bottomLeft: Radius.circular(8),
//                      bottomRight: Radius.circular(8)),
                  color: Colors.white,
                ),
                child: Container(
//                    width: 170,
                  height: 140,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: Text(
                            product.name,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff4B4A5A),
                                fontWeight: FontWeight.w500),
//                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: RatingBarIndicator(
                          rating: product.percentStar,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              NumberFormat.simpleCurrency(locale: "vi")
                                  .format(product.price.priceMax *
                                      (1 - product.promotionPercent / 100))
                                  .toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffE92E22),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                      SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              product.promotionPercent != 0
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        NumberFormat.simpleCurrency(
                                                locale: "vi")
                                            .format(product.price.priceMax)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    )
                                  : Container(),
                              if (hasLike)
                                InkWell(
                                  onTap: onTapFavorite,
                                  child: Icon(
                                    liked? Icons.favorite: Icons.favorite_outline_sharp,
                                    color: liked?Colors.redAccent:Color(0xff4B4A5A).withOpacity(0.5),
                                    size: 30,
                                  ),
                                )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: product.promotionPercent != 0
                ? Container(
//            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                    height: 20,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(10)),
                        color: Color(0xffF6E11E)),
                    child: Center(
                      child: Text(
                        "-" + product.promotionPercent.toString() + "%",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffF34343)),
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
