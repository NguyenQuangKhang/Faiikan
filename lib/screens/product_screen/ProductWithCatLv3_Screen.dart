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
import 'package:faiikan/models/category.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/screens/similar_product_screen/similar_product_screen.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _onWidgetDidBuild(Function() callback) {
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    callback();
  });
}

class ProductWithSubCat_Screen extends StatefulWidget {
  final String title;
  final Category category;
  final int userId;

  ProductWithSubCat_Screen(
      {required this.title, required this.category, required this.userId});

  @override
  _ProductWithSubCat_ScreenState createState() =>
      _ProductWithSubCat_ScreenState();
}

class _ProductWithSubCat_ScreenState extends State<ProductWithSubCat_Screen> {
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  bool flag = true;
  String value = "Giá: Không sắp xếp";
  late ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = context.read<ProductBloc>();
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
        });
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
//            if(context.bloc<ProductBloc>().state.filterRules!=null)
//              {
//                context.bloc<ProductBloc>().add(
//                    ProductGetMoreDataByCategoryCodeEvent(
//                        filter: context.bloc<ProductBloc>().state.filterRules));
//              }
//            else
//              context.bloc<ProductBloc>().add(ProductByCategoryCodeEvent(
//                  categoryPath: widget.category.categoryPath));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text(widget.title,style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.white,
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
      body: BlocBuilder<ProductBloc, ProductsState>(builder: (context, state) {
        if (state is InitialProductState)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
            ),
          );
        return SingleChildScrollView(
          controller: _scrollController2,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(color: Colors.white),
//                      height: MediaQuery.of(context).size.height/3+80,
//                      width:MediaQuery.of(context).size.width ,
//                      padding: EdgeInsets.only(top: 10,left: 10),
//                      margin: EdgeInsets.only(top:10,left:0,bottom: 10),
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Container(
//                                child: Text("TOP SẢN PHẨM BÁN CHẠY", style: TextStyle(fontSize: 10,color: Colors.black45),),
//                                margin: EdgeInsets.only(top:0,left:0),
//                                height: 20,
//                              ),
//                            ],
//
//                          ),
//
//                          Row(
//                            children: <Widget>[
//                              Container(
//                                  height: MediaQuery.of(context).size.height/3+40,
//                                  width:MediaQuery.of(context).size.width -10,
//
//
//
//                                  child: ListView.builder(
//                                      scrollDirection: Axis.horizontal,
//                                      itemCount: productList.length ,
//                                      itemBuilder:(context,index)
//                                      {
//                                        Product product= productList[index];
//                                        return Padding(
//
//                                          padding: EdgeInsets.only(right: 20),
//                                          child:GestureDetector(
//                                              child: Container(
//                                                decoration: BoxDecoration(color: Colors.white,backgroundBlendMode: BlendMode.colorBurn,border: Border.all(color: Colors.black38,)),
//                                                child:
//                                                ProductCard(product: product,index: index,),
//
//                                              ),
//                                              onTap: (){
//                                                Navigator.push(context,MaterialPageRoute(
//                                                    builder: (context)=> Product_Detail(product: product,index: index)
//                                                )
//                                                );
//                                              }
//
//                                          ),
//
//                                        );
//
//                                      }
//
//                                  )
//
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//
//                    ),
//                  Container(
//                       decoration: BoxDecoration(color: Colors.white),
//                      height: MediaQuery.of(context).size.height/3+80,
//                      width:MediaQuery.of(context).size.width ,
//                      padding: EdgeInsets.only(top: 10,left: 10),
//                      margin: EdgeInsets.only(top:10,left:0,bottom: 10),
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Container(
//                                child: Text("TOP SẢN PHẨM MỚI", style: TextStyle(fontSize: 10,color: Colors.black45),),
//                                margin: EdgeInsets.only(top:0,left:0),
//                                height: 20,
//                              ),
//                            ],
//
//                          ),
//
//                          Row(
//                            children: <Widget>[
//                              Container(
//                                  height: MediaQuery.of(context).size.height/3+40,
//                                  width:MediaQuery.of(context).size.width -10,
//
//
//
//                                  child: ListView.builder(
//                                      scrollDirection: Axis.horizontal,
//                                      itemCount: productList.length ,
//                                      itemBuilder:(context,index)
//                                      {
//                                        Product product= productList[index];
//                                        return Padding(
//
//                                          padding: EdgeInsets.only(right: 20),
//                                          child:GestureDetector(
//                                              child: Container(
//                                                decoration: BoxDecoration(color: Colors.white,backgroundBlendMode: BlendMode.colorBurn,border: Border.all(color: Colors.black38,)),
//                                                child:
//                                                ProductCard(product: product,index: index,),
//
//                                              ),
//                                              onTap: (){
//                                                Navigator.push(context,MaterialPageRoute(
//                                                    builder: (context)=> Product_Detail(product: product,index: index)
//                                                )
//                                                );
//                                              }
//
//                                          ),
//
//                                        );
//
//                                      }
//
//                                  )
//
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//
//                    ),
              ///Danh Mục Catelv3 With Icon
              Center(
                child: Container(
                  color: Colors.white,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  //margin: EdgeInsets.only(top:10,left:0,bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Center(
                              child: Container(
                            height: 36,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    child: Container(
                                        height: 20,
                                        width: 100,
                                        margin: index != 0
                                            ? EdgeInsets.only(
                                                left: 10, top: 3, bottom: 3)
                                            : EdgeInsets.only(
                                                left: 0, top: 3, bottom: 3),
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          color: Color(0xff222222),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                            child: Text(
                                          widget
                                              .category.subCategory[index].name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                        ))),
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
                                                      )..add(
                                                          ProductByCategoryCodeEvent(
                                                              categoryId: widget
                                                                  .category
                                                                  .subCategory[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              filter:
                                                                  "popular"));
                                                    },
                                                    child: BlocProvider.value(
                                                      value: context
                                                          .read<CartBloc>(),
                                                      child:
                                                          BlocProvider.value(
                                                            value: context.read<AccountBloc>(),
                                                            child: ProductWithSubCat_Screen(
                                                                userId:
                                                                    widget.userId,
                                                                title: widget
                                                                    .category
                                                                    .subCategory[
                                                                        index]
                                                                    .name,
                                                                category:
                                                                    new Category(
                                                                  id: widget
                                                                      .category
                                                                      .subCategory[
                                                                          index]
                                                                      .id,
                                                                  name: widget
                                                                      .category
                                                                      .subCategory[
                                                                          index]
                                                                      .name,
                                                                  icon: widget
                                                                      .category
                                                                      .subCategory[
                                                                          index]
                                                                      .icon,
                                                                  level: widget
                                                                      .category
                                                                      .subCategory[
                                                                          index]
                                                                      .level,
                                                                  subCat: widget
                                                                      .category
                                                                      .subCategory[
                                                                          index]
                                                                      .subCategory,
                                                                )),
                                                          ),
                                                    ),
                                                  )));
                                    });
                              },
                              itemCount: widget.category.subCategory.length,
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 5, top: 5),
//                padding: EdgeInsets.symmetric(vertical: 5),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: TextButton.icon(
                          onPressed: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (_) => BlocProvider.value(
//                                        value: context.bloc<ProductBloc>(),
//                                        child: Filter_Screen(
//                                            /*category_code: widget.categoryLevel2.level_code*/)
//
//                                        ///TODO
//                                        )));
                          },
                          icon: Icon(
                            Icons.filter_list,
                            color: Colors.black,
                          ),
                          label: Text("Filters")),
                    ),
                    Container(
                      child: GestureDetector(
                        child: TextButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return Column(
                                      children: <Widget>[
                                        ListTile(
                                          title: Text("Giá: Cao -> Thấp"),
                                          onTap: () {
                                            value = "Giá: Cao -> Thấp";
//                                            context.bloc<ProductBloc>().add(FilterandSortByEvent(SortBy: -1,categoryPath: widget.category.categoryPath));
//                                            Navigator.pop(context);
                                            // context.bloc<ProductBloc>().add(ProductGetMoreDataEvent());
                                          },
                                        ),
                                        ListTile(
                                          title: Text("Giá: Thấp -> Cao"),
                                          onTap: () {
                                            value = "Giá: Thấp -> Cao";
//                                              context.bloc<ProductBloc>().add(FilterandSortByEvent(SortBy: 1,level_code: widget.categoryLevel2.level_code));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: Text("Giá: Không sắp xếp"),
                                          onTap: () {
                                            value = "Giá: Không sắp xếp";
//                                              context.bloc<ProductBloc>().add(FilterandSortByEvent(SortBy: 0,level_code: widget.categoryLevel2.level_code));
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.import_export,
                              color: Colors.black,
                            ),
                            label: Text(value)),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),

              Stack(
                children: <Widget>[
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
                 Container(
                          height: MediaQuery.of(context).size.height - 150,
                          color: Color(0xffC4C4C4).withOpacity(0.5),
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
                                        (MediaQuery.of(context).size.width / 2 -
                                                22 / 5) /
                                            (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3 -
                                                2),
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                    //mainAxisSpacing: 4.0,
                                    //childAspectRatio: AppSizes.tile_width / AppSizes.tile_height,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return Container(
//                                        margin: EdgeInsets.only(
//                                          top: 10,
//                                        ),
//                                        padding: EdgeInsets.only(
//                                            left: 10, bottom: 8, right: 10),
                                        color: Colors.white.withOpacity(0),
                                        //padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        child: GestureDetector(
                                            child: ProductCard(
                                              onTapSimilar: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (_) =>
                                                                BlocProvider.value(
                                                                  value: context.read<AccountBloc>(),
                                                                  child: BlocProvider
                                                                      .value(
                                                                    value: context
                                                                        .read<
                                                                            CartBloc>(),
                                                                    child:
                                                                        BlocProvider(
                                                                      create: (_) => SimilarProductBloc(
                                                                          InitialSimilarProductState())
                                                                        ..add(InitiateSimilarProductEvent(
                                                                            productId:
                                                                                productBloc.listdataByCategory[index].id.toString())),
                                                                      child: SimilarProductScreen(
                                                                          interactingProduct: productBloc.listdataByCategory[
                                                                              index],
                                                                          userId:
                                                                              widget.userId),
                                                                    ),
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
                                              product: productBloc
                                                  .listdataByCategory[index],
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
                                                                            id: productBloc.listdataByCategory[index].id,
                                                                            person_id:
                                                                                widget.userId.toString(),
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
                                                                userId: widget
                                                                    .userId,
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
                                                                productId: productBloc
                                                                    .listdataByCategory[
                                                                        index]
                                                                    .id,
                                                              ))));
                                            }),
                                      );
                                    },
                                    childCount:
                                        productBloc.listdataByCategory.length,
                                  ),
                                ),
                              ]),
                        )

                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
