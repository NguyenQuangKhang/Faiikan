import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_bloc.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_event.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_state.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/screens/similar_product_screen/similar_product_screen.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeenProductScreen extends StatelessWidget {
  final int userId;

  const SeenProductScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = context.read<ProductBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Đã xem gần đây",style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 0.5,),),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: <Widget>[],
      ),
      body: Column(
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
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,),);
              return Stack(
                children: <Widget>[
                  Container(
                    //                            padding: EdgeInsets.symmetric(
                    //                                horizontal: 5, vertical: 5),
                    color: Color(0xffC4C4C4).withOpacity(0.5),
                    height: MediaQuery.of(context).size.height - 150,
                    child: CustomScrollView(
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        slivers: <Widget>[
                          SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  (MediaQuery.of(context).size.width / 2 -
                                          22 / 5) /
                                      (MediaQuery.of(context).size.height / 3 -
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
                                                builder: (_) =>
                                                    BlocProvider.value(
                                                      value: context
                                                          .read<CartBloc>(),
                                                      child: BlocProvider(
                                                        create: (_) => SimilarProductBloc(
                                                            InitialSimilarProductState())
                                                          ..add(InitiateSimilarProductEvent(
                                                              productId: productBloc
                                                                  .listSeenProduct[
                                                                      index]
                                                                  .id
                                                                  .toString())),
                                                        child: SimilarProductScreen(
                                                            interactingProduct:
                                                                productBloc
                                                                        .listSeenProduct[
                                                                    index],
                                                            userId: userId),
                                                      ),
                                                    )));
                                      },
                                      onTapFavorite: () {},
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      product: productBloc.listSeenProduct[index],
                                      index: index,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MultiBlocProvider(
                                                      providers: [
                                                        BlocProvider(
                                                            create: (_) =>
                                                                ProductDetailBloc(
                                                                    InitialProductDetail())
                                                                  ..add(
                                                                      ProductDetailLoadEvent(
                                                                    id: productBloc
                                                                        .listSeenProduct[
                                                                            index]
                                                                        .id,
                                                                    person_id:
                                                                        userId
                                                                            .toString(),
                                                                  ))),
                                                        BlocProvider.value(
                                                          value: context
                                                              .read<CartBloc>(),
                                                        ),
                                                      ],
                                                      child: ProductDetail(
                                                        userId: userId,
                                                        percentStar: productBloc
                                                            .listSeenProduct[index]
                                                            .percentStar,
                                                        countRating: productBloc
                                                            .listSeenProduct[index]
                                                            .countRating,
                                                        price: productBloc
                                                            .listSeenProduct[index]
                                                            .price,
                                                        productId: productBloc
                                                            .listSeenProduct[index].id,
                                                      ))));
                                    });
                              },
                              childCount: productBloc.listSeenProduct.length,
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
    );
  }
}
