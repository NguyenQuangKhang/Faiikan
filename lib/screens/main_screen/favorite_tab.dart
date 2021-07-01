import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteBloc.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteEvent.dart';
import 'package:faiikan/blocs/favorite_bloc/FavortieState.dart';
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

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool flag = true;
  late FavoriteBloc productBloc;

  @override
  void initState() {
    productBloc = context.read<FavoriteBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Yêu thích",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Color(0xffE7E7E7),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  ProductDetailBloc(InitialProductDetail())),
          BlocProvider(
            create: (BuildContext context) =>
                CartBloc(InitialCart(data: [], discount: 0, totalPrice: 0))
                  ..add(GetCartEvent(
                      person_id:
                          context.read<AccountBloc>().user.id!.toString())),
          ),
        ],
        child:
            BlocBuilder<FavoriteBloc, FavoriteState>(builder: (index, state) {
          if (state is FavoriteLoading)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
              ),
            );
          return Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.white,
                        child: Text(
                          "Sản phẩm yêu thích",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                  Container(
//                    margin: EdgeInsets.only(
//                      bottom: 5,
//                      left: 5,
//                      right: 5,
//                    ),
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      scrollDirection: Axis.vertical,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2 - 22 / 5) /
                              (MediaQuery.of(context).size.height / 3 - 2.5),
                      // Generate 100 widgets that display their index in the List.
                      children:
                          List.generate(productBloc.listdata.length, (index) {
                        return GestureDetector(
                            child: ProductCard(
                              onTapSimilar: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                              value: context.read<CartBloc>(),
                                              child: BlocProvider(
                                                create: (_) => SimilarProductBloc(
                                                    InitialSimilarProductState())
                                                  ..add(
                                                      InitiateSimilarProductEvent(
                                                          productId: productBloc
                                                              .listdata[index]
                                                              .id
                                                              .toString())),
                                                child: SimilarProductScreen(
                                                    interactingProduct:
                                                        productBloc
                                                            .listdata[index],
                                                    userId: context
                                                        .read<AccountBloc>()
                                                        .user
                                                        .id!),
                                              ),
                                            )));
                              },
                              hasLike: true,
                              liked: productBloc.listdata[index].isLiked,
                              onTapFavorite: () {
                                productBloc.add(FavoriteTap(
                                    person_id: context
                                        .read<AccountBloc>()
                                        .user
                                        .id!
                                        .toString(),
                                    product_id: productBloc.listdata[index].id
                                        .toString(),
                                    index: index));
                              },
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width / 2,
                              product: productBloc.listdata[index],
                              index: index,
                            ),
                            onTap: () {
                              productBloc.index = index;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider.value(
                                                    value: context
                                                        .read<FavoriteBloc>()),
                                                BlocProvider(
                                                    create: (_) => ProductDetailBloc(
                                                        InitialProductDetail())
                                                      ..add(
                                                          ProductDetailLoadEvent(
                                                        id: productBloc
                                                            .listdata[index].id,
                                                        person_id: context
                                                            .read<AccountBloc>()
                                                            .user
                                                            .id
                                                            .toString(),
                                                      ))),
                                                BlocProvider.value(
                                                  value:
                                                      context.read<CartBloc>(),
                                                ),
                                              ],
                                              child: ProductDetail(
                                                userId: context
                                                    .read<AccountBloc>()
                                                    .user
                                                    .id!,
//                                                isNavigatedFromFavorite: true,


                                                percentStar: productBloc
                                                    .listdata[index]
                                                    .percentStar,
                                                countRating: productBloc
                                                    .listdata[index]
                                                    .countRating,
                                                price: productBloc
                                                    .listdata[index].price,
                                                productId: productBloc
                                                    .listdata[index].id,
                                              ))));
                            });
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                  Container(
                    height: MediaQuery.of(context).size.height / 4 < 200
                        ? 200
                        : MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productBloc.listRecommendTopRating.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                child: ProductCard(
                                  onTapSimilar: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                                  value:
                                                      context.read<CartBloc>(),
                                                  child: BlocProvider(
                                                    create: (_) => SimilarProductBloc(
                                                        InitialSimilarProductState())
                                                      ..add(InitiateSimilarProductEvent(
                                                          productId: productBloc
                                                              .listRecommendTopRating[
                                                                  index]
                                                              .id
                                                              .toString())),
                                                    child: SimilarProductScreen(
                                                        interactingProduct:
                                                            productBloc
                                                                    .listRecommendTopRating[
                                                                index],
                                                        userId: context
                                                            .read<AccountBloc>()
                                                            .user
                                                            .id!),
                                                  ),
                                                )));
                                  },
                                  onTapFavorite: () {},
                                  height: MediaQuery.of(context).size.height /
                                              4 <
                                          200
                                      ? 200
                                      : MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width / 3,
                                  product:
                                      productBloc.listRecommendTopRating[index],
                                  index: index,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider.value(
                                                      value: context
                                                          .read<FavoriteBloc>()),
                                                  BlocProvider.value(
                                                      value: context.read<
                                                          ProductDetailBloc>()
                                                        ..add(
                                                            ProductDetailLoadEvent(
                                                          id: productBloc
                                                              .listRecommendTopRating[
                                                                  index]
                                                              .id,
                                                          person_id: context
                                                              .read<
                                                                  AccountBloc>()
                                                              .user
                                                              .id
                                                              .toString(),
                                                        ))),
                                                  BlocProvider.value(
                                                    value: context
                                                        .read<CartBloc>(),
                                                  ),
                                                ],
                                                child: ProductDetail(
                                                  userId: context
                                                      .read<AccountBloc>()
                                                      .user
                                                      .id!,
                                                  isInFavorite: true,
                                                  percentStar: productBloc
                                                      .listRecommendTopRating[
                                                          index]
                                                      .percentStar,
                                                  countRating: productBloc
                                                      .listRecommendTopRating[
                                                          index]
                                                      .countRating,
                                                  price: productBloc
                                                      .listRecommendTopRating[
                                                          index]
                                                      .price,
                                                  productId: productBloc
                                                      .listRecommendTopRating[
                                                          index]
                                                      .id,
                                                ))));
                              });
                        }),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
