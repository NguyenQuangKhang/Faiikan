import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_bloc.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_event.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_state.dart';
import 'package:faiikan/screens/main_screen/main_screen.dart';
import 'package:faiikan/screens/my_order_screen/my_order_screen.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/screens/similar_product_screen/similar_product_screen.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessfulOrder extends StatefulWidget {
  @override
  _SuccessfulOrderState createState() => _SuccessfulOrderState();
}

class _SuccessfulOrderState extends State<SuccessfulOrder> {
  int _current = 0;
  int time = 23 * 3600;
  late ProductBloc productBloc;
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  bool flag = true;

  @override
  void initState() {
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
        context.read<ProductBloc>().add(ProductGetMoreDataEvent(SortBy: 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController2,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Image.network(
              "https://img.freepik.com/free-vector/card-template-with-fireworks-party-horns_1308-3021.jpg?size=626&ext=jpg",
              height: MediaQuery.of(context).size.width - 50,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.redAccent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<AccountBloc>(),child: MainScreen(),)));
                    },
                    child: Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                          value: context.read<AccountBloc>(),
                                          child: MainScreen())));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  border: Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  "Trang chủ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyOrderScreen(
                                      userId: context.read<AccountBloc>().userId.toString(),
                                      initialTab: 0,
                                    )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                border: Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                "Đơn mua",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  color: Colors.white,
                  child: Text(
                    "Gợi ý cho bạn",
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
              height: 5,
              color: Color(0xffC4C4C4).withOpacity(0.5)
            ),
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
//                  Container(
//                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                    decoration: BoxDecoration(
//                        border: Border(
//                            top: BorderSide(
//                              color: Color(0xffE7E7E7),
//                              width: 5,
//                            ),
//                            bottom: BorderSide(
//                              color: Color(0xffE7E7E7),
//                              width: 5,
//                            ))),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        Row(
//                          children: [
//                            Icon(
//                              Icons.filter_list,
//                              size: 30,
//                              color: Color(0xff222222),
//                            ),
//                            Text(
//                              "Lọc",
//                              style: TextStyle(
//                                color: Color(0xff222222),
//                                fontSize: 14,
//                                letterSpacing: 0.5,
//                                fontWeight: FontWeight.w500,
//                              ),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Icon(
//                              Icons.refresh_rounded,
//                              color: Color(0xff222222),
//                              size: 30,
//                            ),
//                            Text(
//                              "Phổ biến",
//                              style: TextStyle(
//                                color: Color(0xff222222),
//                                fontSize: 14,
//                                letterSpacing: 0.5,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
                    Expanded(
                      child: BlocBuilder<ProductBloc, ProductsState>(
                        builder: (context, state) {
                          return Stack(
                            children: <Widget>[
                              Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 5, vertical: 5),
                                color: Color(0xffE7E7E7),
                                width:MediaQuery.of(context).size.width,
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
                                                                          .listdata[index]
                                                                          .id
                                                                          .toString())),
                                                                child: SimilarProductScreen(
                                                                    interactingProduct:
                                                                    productBloc.listdata[
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
                                                  productBloc.listdata[index],
                                                  index: index,
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              MultiBlocProvider(
                                                                  providers: [
                                                                    BlocProvider.value(
                                                                        value: context
                                                                            .read<
                                                                            AccountBloc>()),
                                                                    BlocProvider.value(
                                                                        value: context
                                                                            .read<
                                                                            ProductBloc>()),
                                                                    BlocProvider(
                                                                        create: (_) =>
                                                                        ProductDetailBloc(
                                                                            InitialProductDetail())
                                                                          ..add(
                                                                              ProductDetailLoadEvent(
                                                                                id: productBloc.listdata[index].id,
                                                                                person_id: context.read<AccountBloc>().userId == 0
                                                                                    ? "0"
                                                                                    : context.read<AccountBloc>().user!.id.toString(),
                                                                              ))),
                                                                    if (context
                                                                        .read<
                                                                        AccountBloc>()
                                                                        .userId !=
                                                                        0)
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
                                                                        .userId ==
                                                                        0
                                                                        ? 0
                                                                        : context
                                                                        .read<
                                                                        AccountBloc>()
                                                                        .user!
                                                                        .id!,
                                                                    percentStar: productBloc
                                                                        .listdata[
                                                                    index]
                                                                        .percentStar,
                                                                    countRating: productBloc
                                                                        .listdata[
                                                                    index]
                                                                        .countRating,
                                                                    price: productBloc
                                                                        .listdata[
                                                                    index]
                                                                        .price,
                                                                    productId:
                                                                    productBloc
                                                                        .listdata[
                                                                    index]
                                                                        .id,
                                                                  ))));
                                                });
                                          },
                                          childCount: productBloc.listdata.length,
                                        ),
                                      ),
                                    ]),
                              ),
                              if (state is Loading)
                                Center(
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
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
