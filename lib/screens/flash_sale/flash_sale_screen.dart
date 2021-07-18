import 'dart:async';

import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/models/product.dart' as product;
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/flash_sale_bloc/flash_sale_bloc.dart';
import 'package:faiikan/blocs/flash_sale_bloc/flash_sale_event.dart';
import 'package:faiikan/blocs/flash_sale_bloc/flash_sale_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/screens/payment_screen/payment_screen.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/screens/successful_order/successful_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FlashSaleScreen extends StatefulWidget {
  @override
  _FlashSaleScreenState createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int time = 23 * 3600;
  ScrollController scrollController = ScrollController();
  int selectedTabIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: context
        .read<FlashSaleBloc>()
        .period
        .length, vsync: this);
    tabController.addListener(() {
      if (tabController.index != selectedTabIndex) {
        setState(() {
          selectedTabIndex = tabController.index;
        });
        context.read<FlashSaleBloc>().add(LoadProductOfPeriod(id: context
            .read<FlashSaleBloc>()
            .period[selectedTabIndex].id!));
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 10) {
        context.read<FlashSaleBloc>().add(LoadMoreProductOfPeriod(id: context
            .read<FlashSaleBloc>()
            .period[selectedTabIndex].id!));
      }
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) time--;
      });
    });
    for (int i = 0; i < context
        .read<FlashSaleBloc>()
        .period
        .length; i++) {
      if (context
          .read<FlashSaleBloc>()
          .period[i].status == "Đang diễn ra")
        selectedTabIndex = i;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: context
          .read<FlashSaleBloc>()
          .period
          .length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF34646),
          title: Text(
            "FLASH SALE",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xffE7E7E7),
        body: BlocListener(
          bloc: context.read<FlashSaleBloc>(),
          listener: (context, state) {
            if (state is SucessfulGetPeriodState) {

                if (context
                    .read<FlashSaleBloc>()
                    .period[selectedTabIndex].id == context
                    .read<FlashSaleBloc>()
                    .idPeriod) {
                  DateTime endTime = DateFormat('HH:mm:ss').parse(context
                      .read<FlashSaleBloc>()
                      .period[selectedTabIndex].endTime!);
                  setState(() {
                    time = endTime.hour * 3600 + endTime.minute * 60 +
                        endTime.second - (DateTime
                        .now()
                        .hour * 3600 + DateTime
                        .now()
                        .minute * 60 + DateTime
                        .now()
                        .second);
                    print("time" + time.toString());
                  });
                }
            }
          },
          child: Column(
            children: [
              Container(
                height: 70,
                color: Colors.white,
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: Colors.black,
                  tabs: [
                    ...List.generate(context
                        .read<FlashSaleBloc>()
                        .period
                        .length, (index) =>
                        Container(
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    context
                                        .read<FlashSaleBloc>()
                                        .period[index].startTime!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: selectedTabIndex == index ? Color(
                                          0xffF34646) : Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    context
                                        .read<FlashSaleBloc>()
                                        .period[index].status!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: selectedTabIndex == index ? Color(
                                          0xffF34646) : Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              )),
                        ),),

                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    if(context
                        .read<FlashSaleBloc>()
                        .period[selectedTabIndex].id == context
                        .read<FlashSaleBloc>()
                        .idPeriod ) Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "KẾT THÚC TRONG",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(1)),
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
                        ],
                      ),
                    ),
                    BlocBuilder<FlashSaleBloc, FlashSaleState>(
                        builder: (context, state) {
                          if (state is LoadingFlashSale)
                            return Center(child: CircularProgressIndicator(
                              backgroundColor: Colors.redAccent,),);
                          return Expanded(
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              color: Colors.white,
                              child: ListView.builder(
                                  itemCount: context
                                      .read<FlashSaleBloc>()
                                      .dataOfPeriod
                                      .length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return InkWell(
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
                                                                      id: context
                                                                          .read<
                                                                          FlashSaleBloc>()
                                                                          .dataOfPeriod[index]
                                                                          .productItem!
                                                                          .id!,
                                                                      person_id: context
                                                                          .read<
                                                                          AccountBloc>()
                                                                          .userId ==
                                                                          0
                                                                          ? "0"
                                                                          : context
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
                                                          userId: context
                                                              .read<
                                                              AccountBloc>()
                                                              .user!
                                                              .id!,
                                                          percentStar: 0,
                                                          countRating: 0,
                                                          price: new product
                                                              .Price(
                                                              priceMax: context
                                                                  .read<
                                                                  FlashSaleBloc>()
                                                                  .dataOfPeriod[index]
                                                                  .productItem!
                                                                  .price!
                                                                  .priceMax!,
                                                              priceMin: context
                                                                  .read<
                                                                  FlashSaleBloc>()
                                                                  .dataOfPeriod[index]
                                                                  .productItem!
                                                                  .price!
                                                                  .priceMin!),
                                                          productId:
                                                          context
                                                              .read<
                                                              FlashSaleBloc>()
                                                              .dataOfPeriod[index]
                                                              .productItem!.id!,
                                                        ))));
                                      },
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height /
                                                    4,
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      context
                                                          .read<FlashSaleBloc>()
                                                          .dataOfPeriod[index]
                                                          .productItem!
                                                          .imgUrl!,
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width /
                                                          4,
                                                      height: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height /
                                                          4 -
                                                          20,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            context
                                                                .read<
                                                                FlashSaleBloc>()
                                                                .dataOfPeriod[index]
                                                                .productItem!
                                                                .name!,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              letterSpacing: 0.5,
                                                            ),
                                                            maxLines: null,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                NumberFormat
                                                                    .simpleCurrency(
                                                                    locale: "vi")
                                                                    .format(
                                                                    context
                                                                        .read<
                                                                        FlashSaleBloc>()
                                                                        .dataOfPeriod[index]
                                                                        .productItem!
                                                                        .price!
                                                                        .priceMax)
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 10,
                                                                    color:
                                                                    Color(
                                                                        0xffB8B6B6),
                                                                    decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "-" + context
                                                                    .read<
                                                                    FlashSaleBloc>()
                                                                    .dataOfPeriod[index]
                                                                    .percentDiscount
                                                                    .toString() +
                                                                    "%",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  color:
                                                                  Color(
                                                                      0xffFE8E0B),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            NumberFormat
                                                                .simpleCurrency(
                                                                locale: "vi")
                                                                .format(context
                                                                .read<
                                                                FlashSaleBloc>()
                                                                .dataOfPeriod[index]
                                                                .productItem!
                                                                .price!
                                                                .priceMax! *
                                                                context
                                                                    .read<
                                                                    FlashSaleBloc>()
                                                                    .dataOfPeriod[index]
                                                                    .percentDiscount! /
                                                                100)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xffF34646)),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width /
                                                                3,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                color: Color(
                                                                    0xffD3D3D3)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                color: Color(0xffC4C4C4),
                                              ),
                                            ],
                                          ),
//                                      Positioned(
//                                        right: 10,
//                                          bottom: 10,
//                                          child: InkWell(
//                                            onTap: (){
//                                              Navigator.push(context, MaterialPageRoute(builder: (_)
//                                              =>
//                                                  BlocProvider.value(
//                                                      value: context.read<CartBloc>(),
//                                                      child: BlocProvider.value(
//                                                          value: context.read<ProductBloc>(),
//                                                          child: BlocProvider.value(
//                                                              value: context.read<AccountBloc>(),
//                                                              child: BlocProvider(
//                                                                create: (_) => AddressBloc(LoadAddress())
//                                                                  ..add(InitialAddressEvent(userId: context.read<AccountBloc>().userId.toString())),
//                                                                child: PaymentScreen(
//                                                                    userId: context.read<AccountBloc>().userId.toString(),
//                                                                    listItems: [
//                                                                      CartItem.CartItem(
//                                                                          cartId: 0,
//                                                                          productId: productDetailBloc
//                                                                              .productDetail.id,
//                                                                          nameProduct: productDetailBloc
//                                                                              .productDetail
//                                                                              .name,
//                                                                          amount: productDetailBloc
//                                                                              .amount,
//                                                                          optionProduct: CartItem.OptionProduct(
//                                                                              productOptionId: optionProduct
//                                                                                  .productOptionId,
//                                                                              price: CartItem.Price(
//                                                                                  value: optionProduct
//                                                                                      .price
//                                                                                      .value,
//                                                                                  id: optionProduct
//                                                                                      .price
//                                                                                      .id),
//                                                                              quantity: CartItem.Quantity(
//                                                                                  value: optionProduct.quantity.value,
//                                                                                  id: optionProduct.quantity.id),
//                                                                              color: CartItem.Color(value: productDetailBloc.options.length > 1 ? productDetailBloc.options[1] : "", id: 0),
//                                                                              size: CartItem.Size(id: 0, value: productDetailBloc.options[0]),
//                                                                              image: CartItem.Image(value: images[0], id: 0)))
//                                                                    ], ),
//                                                              ))))
//                                              ));
//                                            },
//                                            child: Container(
//                                              padding: EdgeInsets.all(10),
//                                              decoration: BoxDecoration(
//                                                  color: Color(0xffF34646),
//                                                  borderRadius: BorderRadius.circular(5)
//                                              ),
//                                              child: Text("Mua ngay",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,),),
//                                            ),
//                                          ))
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),


        ),
      ),
    );
  }
}
