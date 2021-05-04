import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/widgets/search_field.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  final String title;
  final bool isBack;
  final Color backgroundColor;
  final isRedTitle;

  const CustomAppBar(
      {required this.bottom,
      this.title = "FaiiKan",
      this.isRedTitle = false,
      this.isBack = false,
      this.backgroundColor = Colors.white});

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
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SearchField(
                            text: "Bạn tìm gì hôm nay?",
                          )))
                ],
              )
            : Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
        backgroundColor: backgroundColor,
        bottom: bottom,
        actions: isRedTitle
            ? [
                Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 10),
              ]
            : null,
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
