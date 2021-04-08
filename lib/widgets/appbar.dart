import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  final String title;
  final bool isBack;
  final Color backgroundColor;
  const CustomAppBar(
      {this.bottom, this.title = "FaiiKan", this.isBack = false,this.backgroundColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: TextStyle(color: Colors.black),),
      backgroundColor: backgroundColor,
      bottom: bottom,
        leading: isBack
            ? IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black.withOpacity(0.6),),
          onPressed: () {
            Navigator.pop(context);
          },
        ) : null
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(
      56.0 + (bottom != null ? bottom.preferredSize.height : 0));
}
