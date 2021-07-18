import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_bloc.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_event.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_state.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SimilarProductScreen extends StatefulWidget {
  final Product interactingProduct;
  final int userId;

  const SimilarProductScreen({
    required this.interactingProduct,
    required this.userId,
  });

  @override
  _SimilarProductScreenState createState() => _SimilarProductScreenState();
}

class _SimilarProductScreenState extends State<SimilarProductScreen> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent - 10) {
        context.read<SimilarProductBloc>().add(LoadMoreSimilarProductEvent(
            productId: widget.interactingProduct.id.toString()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Sản phẩm tương tự",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.redAccent.withOpacity(0.5),
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ],
                    border:
                        Border.all(color: Colors.redAccent.withOpacity(0.5))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.network(
                        widget.interactingProduct.imgUrl,
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                widget.interactingProduct.name, maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff4B4A5A),
                                    fontWeight: FontWeight.w500),
//                            textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  NumberFormat.simpleCurrency(locale: "vi")
                                      .format(widget.interactingProduct.price
                                              .priceMax *
                                          (1 -
                                              widget.interactingProduct
                                                      .promotionPercent /
                                                  100))
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xffE92E22),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                widget.interactingProduct.promotionPercent != 0
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: "vi")
                                              .format(widget.interactingProduct
                                                  .price.priceMax)
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  width: 5,
                                ),
                                widget.interactingProduct.promotionPercent != 0
                                    ? Container(
//            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                        height: 20,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            color: Color(0xffF6E11E)),
                                        child: Center(
                                          child: Text(
                                            "-" +
                                                widget.interactingProduct
                                                    .promotionPercent
                                                    .toString() +
                                                "%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xffF34343)),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                            create: (_) => ProductDetailBloc(
                                                InitialProductDetail())
                                              ..add(ProductDetailLoadEvent(
                                                id: widget
                                                    .interactingProduct.id,
                                                person_id:
                                                    widget.userId.toString(),
                                              ))),
                                        BlocProvider.value(
                                          value: context.read<CartBloc>(),
                                        ),
                                      ],
                                      child: ProductDetail(
                                        userId: widget.userId,
                                        percentStar: widget
                                            .interactingProduct.percentStar,
                                        countRating: widget
                                            .interactingProduct.countRating,
                                        price: widget.interactingProduct.price,
                                        productId: widget.interactingProduct.id,
                                      ))));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.redAccent,
                          )),
                      child: Text(
                        "Mua ngay",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Sản phẩm tương tự",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 5,
            color: Color(0xffE7E7E7),
          ),
          Expanded(
            child: BlocBuilder<SimilarProductBloc, SimilarProductState>(
              builder: (context, state) {
                if (state is InitialSimilarProductState ||
                    state is LoadingSimilarProduct)
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                return Stack(
                  children: <Widget>[
                    Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 5, vertical: 5),
                      color: Color(0xffE7E7E7),
                      child: CustomScrollView(
                          shrinkWrap: true,
                          primary: false,
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          slivers: <Widget>[
                            SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.width / 2 -
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
                                        hasPopupMenu: false,
                                        onTapSimilar: () {},
                                        onTapFavorite: () {},
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        product: context
                                            .read<SimilarProductBloc>()
                                            .data[index],
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
                                                                      id: context
                                                                          .read<
                                                                              SimilarProductBloc>()
                                                                          .data[
                                                                              index]
                                                                          .id,
                                                                      person_id: widget
                                                                          .userId
                                                                          .toString(),
                                                                    ))),
                                                          BlocProvider.value(
                                                            value: context.read<
                                                                CartBloc>(),
                                                          ),
                                                          BlocProvider.value(
                                                            value: context.read<
                                                                AccountBloc>(),
                                                          ),
                                                        ],
                                                        child: ProductDetail(
                                                          userId: widget.userId,
                                                          percentStar: context
                                                              .read<
                                                                  SimilarProductBloc>()
                                                              .data[index]
                                                              .percentStar,
                                                          countRating: context
                                                              .read<
                                                                  SimilarProductBloc>()
                                                              .data[index]
                                                              .countRating,
                                                          price: context
                                                              .read<
                                                                  SimilarProductBloc>()
                                                              .data[index]
                                                              .price,
                                                          productId: context
                                                              .read<
                                                                  SimilarProductBloc>()
                                                              .data[index]
                                                              .id,
                                                        ))));
                                      });
                                },
                                childCount: context
                                    .read<SimilarProductBloc>()
                                    .data
                                    .length,
                              ),
                            ),
                          ]),
                    ),
                    if (state is LoadMoreSimilarProduct)
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
          )
        ],
      ),
    );
  }
}
