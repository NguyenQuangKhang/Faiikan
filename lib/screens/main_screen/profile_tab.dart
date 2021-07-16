import 'package:auto_size_text/auto_size_text.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountEvent.dart';
import 'package:faiikan/blocs/account_bloc/AccountState.dart';
import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteBloc.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteEvent.dart';
import 'package:faiikan/blocs/favorite_bloc/FavortieState.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_event.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';

import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_bloc.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_event.dart';
import 'package:faiikan/blocs/similar_product_bloc/similar_product_state.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/screens/address_screen/my_address.dart';
import 'package:faiikan/screens/main_screen/favorite_tab.dart';
import 'package:faiikan/screens/my_order_screen/my_order_screen.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/screens/register_login_screen/login_screen.dart';
import 'package:faiikan/screens/register_login_screen/register_and_login_screen.dart';
import 'package:faiikan/screens/review_screen/my_review_screen.dart';
import 'package:faiikan/screens/seen_product/seen_product.dart';
import 'package:faiikan/screens/similar_product_screen/similar_product_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final int userId;

  const ProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    print(userId);
    return Container(
      color: Color(0xffE7E7E7),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            BlocBuilder<AccountBloc,AccountState>(
              builder: (context,state) => Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 30,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3 +30,
                        decoration: BoxDecoration(
                          color: Color(0xffF34646),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 10,
                                    top: 30,
                                  ),
                                  child: Icon(
                                    CustomIcon.setting,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5), //10
                                    height: 60, //140
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4, //8
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            context.read<AccountBloc>().user==null?   "https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg"  :context.read<AccountBloc>().user!.imageUrl!),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(
                                              0, 0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (context.read<AccountBloc>().userId != 0)
                                    Column(
                                      children: [
                                        Text(
                                          context.read<AccountBloc>().user!.name!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                       if(context.read<AccountBloc>().user!.email !=null) Text(
                                            context.read<AccountBloc>().user!.email!,
                                         style: TextStyle(
                                           color: Colors.white.withOpacity(0.7),
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                         ),
                                        ),
                                      ],
                                    )
                                  else
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      BlocProvider.value(
                                                    value: context
                                                        .read<AccountBloc>(),
                                                    child: RegisterAndLoginScreen(
                                                      initialIndex: 1,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Đăng nhập",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                        Text(
                                          " / ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    BlocProvider.value(
                                                  value:
                                                      context.read<AccountBloc>(),
                                                  child: RegisterAndLoginScreen(
                                                    initialIndex: 0,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Đăng ký",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2 +
                                        200,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Text(
                                                "0",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "Voucher",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "0",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "Điểm",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 12,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2 -
                            60 -
                            MediaQuery.of(context).size.height / 12 -
                            50,
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                            left: 10,
                          ),
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.height / 6 <130 ? 135:MediaQuery.of(context).size.height / 6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Đơn mua",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (context.read<AccountBloc>().userId !=
                                            0)
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => BlocProvider.value(
                                                    value: context.read<CartBloc>(),
                                                    child: BlocProvider.value(
                                                      value: context.read<ProductBloc>(),
                                                      child: BlocProvider.value(
                                                        value: context.read<AccountBloc>(),
                                                        child: MyOrderScreen(
                                                              userId: userId.toString(),
                                                              initialTab: 0,
                                                            ),
                                                      ),
                                                    ),
                                                  )));
                                        else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Mời đăng nhập để xem đơn hàng."),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Xem lịch sử mua hàng",
                                            style: TextStyle(
                                                color:
                                                    Colors.black.withOpacity(0.7),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: Color(0xff666666),
                                            size: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    left: 10,
                                    right: 10,
                                    bottom: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            if (context
                                                    .read<AccountBloc>()
                                                    .userId !=
                                                0)
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                BlocProvider.value(
                                                    value: context.read<CartBloc>(),
                                                    child: BlocProvider.value(
                                                      value: context.read<ProductBloc>(),
                                                            child: BlocProvider.value(
                                                              value: context.read<AccountBloc>(),
                                                              child: MyOrderScreen(
                                                                userId:
                                                                    userId.toString(),
                                                                initialTab: 0,
                                                              ),
                                                            ),
                                                          ))));
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/choxacnhan.png",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              AutoSizeText(
                                                "Chờ xác nhận",
                                                maxLines: 1,
                                                minFontSize: 12,
                                                maxFontSize: 20,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  letterSpacing: 0.5,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            if (context
                                                    .read<AccountBloc>()
                                                    .userId !=
                                                0)
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                BlocProvider.value(
                                                    value: context.read<CartBloc>(),
                                                    child: BlocProvider.value(
                                                      value: context.read<ProductBloc>(),
                                                            child: BlocProvider.value(
                                                              value: context.read<AccountBloc>(),
                                                              child: MyOrderScreen(
                                                                userId:
                                                                    userId.toString(),
                                                                initialTab: 1,
                                                              ),
                                                            ),
                                                          ))));
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/cholayhang.png",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              AutoSizeText(
                                                "Chờ lấy hàng",
                                                maxLines: 1,
                                                minFontSize: 12,
                                                maxFontSize: 20,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  letterSpacing: 0.5,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            if (context
                                                    .read<AccountBloc>()
                                                    .userId !=
                                                0)
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                BlocProvider.value(
                                                    value: context.read<CartBloc>(),
                                                    child: BlocProvider.value(
                                                      value: context.read<ProductBloc>(),
                                                            child: BlocProvider.value(
                                                              value: context.read<AccountBloc>(),
                                                              child: MyOrderScreen(
                                                                userId:
                                                                    userId.toString(),
                                                                initialTab: 2,
                                                              ),
                                                            ),
                                                          ))));
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/danggiao.png",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              AutoSizeText(
                                                "Đang giao",
                                                minFontSize: 12,
                                                maxLines: 1,
                                                maxFontSize: 20,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  letterSpacing: 0.5,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => BlocProvider.value(
                                                value: context.read<CartBloc>(),
                                                child: BlocProvider.value(
                                                  value: context.read<ProductBloc>(),
                                                      child: BlocProvider.value(
                                                        value: context.read<AccountBloc>(),
                                                        child: MyOrderScreen(
                                                              userId:
                                                                  userId.toString(),
                                                              initialTab: 3,
                                                            ),
                                                      ),
                                                    ))));
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/dagiao.png",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              AutoSizeText(
                                                "Đã giao",
                                                minFontSize: 12,
                                                maxFontSize: 20,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  letterSpacing: 0.5,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => /*context.read<AccountBloc>().userId == 0
                              ? BlocProvider.value(
                                  value: context.read<AccountBloc>(),
                                  child: RegisterAndLoginScreen(
                                    initialIndex: 1,
                                  ),
                                )
                              : */BlocProvider(
                                  create: (_) => ProductBloc(
                                      InitialProductState(
                                        data: [],
                                        error: "",
                                        sortBy: 0,
                                      ),
                                    )..add(SeenProductEvent(
                                        userId: userId.toString())),
                                  child: BlocProvider.value(
                                      value: context.read<CartBloc>(),
                                      child: SeenProductScreen(
                                        userId: userId,
                                      )),
                                ),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CustomIcon.recently_seen,
                              color: Color(0xff2284CA),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Đã xem gần đây",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color(0xff666666),
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MyReviewScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CustomIcon.my_review,
                              color: Color(0xff1A7A24),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Đánh giá của tôi",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color(0xff666666),
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                  value: context.read<AccountBloc>()),

                                BlocProvider.value(
                                  value: context.read<CartBloc>(),
                                ),

                                BlocProvider(
                                  create: (BuildContext context) =>
                                      FavoriteBloc(InitialFavorite(data: []))
                                        ..add(FavoriteLoadEvent(
                                            person_id: context
                                                .read<AccountBloc>()
                                                .user!
                                                .id!
                                                .toString())),
                                )
                            ],
                            child: FavoriteScreen(),
                          ),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sản phẩm yêu thích",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color(0xff666666),
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CustomIcon.account,
                            color: Color(0xff2E53B1),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Thiết lập tài khoản",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Color(0xff666666),
                            size: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider(
                                  create: (_) =>
                                      AddressBloc(InitialAddressState())
                                        ..add(InitialAddressEvent(
                                            userId: userId.toString())),
                                  child:
                                      MyAddressScreen(userId: userId.toString()),
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              color: Color(0xffDF8365),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Địa chỉ giao hàng",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color(0xff666666),
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CustomIcon.help,
                            color: Color(0xffC23E2C),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Trung tâm trợ giúp",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Color(0xff666666),
                            size: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "Bạn có muốn đăng xuất? ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                          onTap: () =>
                                              Navigator.of(context).pop(false),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xffC4C4C4)
                                                          .withOpacity(0.5))),
                                              child: Center(
                                                  child: const Text(
                                                    "KHÔNG",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  )))),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          context
                                              .read<AccountBloc>()
                                              .add(LogOutEvent());
                                          Navigator.pop(context);
                                        },
                                        child: Container(
//                                              padding: EdgeInsets.symmetric(
//                                                  vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffC4C4C4)
                                                      .withOpacity(0.5))),
                                          child: Center(
                                              child: const Text(
                                                "ĐỒNG Ý",
                                                style: TextStyle(
                                                  color: Color(0xffF34646),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Color(0xff2E53B1),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Đăng xuất",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color(0xff666666),
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "CÓ THỂ BẠN THÍCH",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 16,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<ProductBloc, ProductsState>(
                    builder: (context, state) {
                  if (state is InitialProductState || state is Loading)
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height / 4 + 20,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: InkWell(
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
                                                                      id: context
                                                                          .read<
                                                                              ProductBloc>()
                                                                          .listdata[
                                                                              index]
                                                                          .id,
                                                                      person_id: context
                                                                          .read<
                                                                              AccountBloc>()
                                                                          .user!
                                                                          .id
                                                                          .toString(),
                                                                    ))),
                                                          BlocProvider.value(value: context.read<AccountBloc>()),
                                                          BlocProvider.value(
                                                            value: context
                                                                .read<CartBloc>(),
                                                          ),
                                                        ],
                                                        child: ProductDetail(
                                                          userId: context
                                                              .read<AccountBloc>()
                                                              .user!
                                                              .id!,
                                                          percentStar: context
                                                              .read<ProductBloc>()
                                                              .listdata[index]
                                                              .percentStar,
                                                          countRating: context
                                                              .read<ProductBloc>()
                                                              .listdata[index]
                                                              .countRating,
                                                          price: context
                                                              .read<ProductBloc>()
                                                              .listdata[index]
                                                              .price,
                                                          productId: context
                                                              .read<ProductBloc>()
                                                              .listdata[index]
                                                              .id,
                                                        ))));
                                      },
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
                                                                productId: context
                                                                    .read<
                                                                        ProductBloc>()
                                                                    .listdata[
                                                                        index]
                                                                    .id
                                                                    .toString())),
                                                          child: SimilarProductScreen(
                                                              interactingProduct: context
                                                                  .read<
                                                                      ProductBloc>()
                                                                  .listdata[index],
                                                              userId: userId),
                                                        ),
                                                      )));
                                        },
                                        onTapFavorite: () {},
                                        width:
                                            MediaQuery.of(context).size.width / 3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        product: context
                                            .read<ProductBloc>()
                                            .listdata[index],
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    context.read<ProductBloc>().listdata.length,
                              )),
                        ],
                      ),
                    ],
                  );
                }),
              ],
          ),
            ),
      ),
    );
  }
}
