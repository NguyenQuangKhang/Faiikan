import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/search_bloc/search_bloc.dart';
import 'package:faiikan/blocs/search_bloc/search_event.dart';
import 'package:faiikan/blocs/search_bloc/search_state.dart';
import 'package:faiikan/screens/search_screen/search_screen.dart';
import 'package:faiikan/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  final String title;
  final bool isBack;
  final Color backgroundColor;
  final bool isRedTitle;
  final bool isCenterRedTitle;
  final VoidCallback onTapCart;
  final VoidCallback onTapNotification;

  const CustomAppBar(
      {required this.bottom,
      this.title = "FaiiKan",
        this.isCenterRedTitle=false,
      this.isRedTitle = false,
      this.isBack = false,
      this.backgroundColor = Colors.white,
      required this.onTapCart,
      required this.onTapNotification});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: isRedTitle
            ? Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "FAII",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "KAN",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: Color(0xffEF5454),
                            ),

                          ),
                        ]),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider(
                                            create: (_) =>
                                                SearchBloc(InitialSearchState())
                                                  ..add(InitiateSearchEvent(
                                                      userId: context
                                                          .read<AccountBloc>()
                                                          .user!
                                                          .id!
                                                          .toString())),
                                            child: BlocProvider.value(
                                              value: context.read<CartBloc>(),
                                              child: SearchScreen(userId:context
                                                  .read<AccountBloc>()
                                                  .user!
                                                  .id!
                                                   ,),
                                            ),
                                          )));
                            },
                            child: SearchField(
                              text: "Bạn tìm gì hôm nay?",
                            ),
                          )))
                ],
              )
            : isCenterRedTitle? Center(
              child: RichText(
          text: TextSpan(
                text: "FAII",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: "KAN",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: Color(0xffEF5454),
                    ),

                  ),
                ]),
        ),
            ) :Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
        backgroundColor: backgroundColor,
        bottom: bottom,
        actions: isRedTitle
            ? [
                InkWell(
                  onTap: onTapNotification,
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: onTapCart,
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 5,
                        child: Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                )),
                            child: Center(
                              child: context.read<AccountBloc>().userId==0? Text(
                              "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            ): BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                                  if (state is InitialCart)
                                    return Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    );
                                  return Text(
                                   context
                                        .read<CartBloc>()
                                        .list_data
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  );
                                },
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ]
            : null,
        leadingWidth: isRedTitle ? 0 : 100,
        leading: isBack
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black.withOpacity(0.6),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(
        56.0 + bottom.preferredSize.height,
      );
}
