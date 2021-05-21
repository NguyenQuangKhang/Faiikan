import 'package:faiikan/models/category.dart';
import 'package:flutter/material.dart';

class Category1Button extends StatelessWidget {
  final Category data;
  final bool isSelected;
  final Color bgColor;
  final VoidCallback onTap;
  const Category1Button({this.isSelected=false,required this.bgColor,required this.data,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(

      decoration: BoxDecoration( color: isSelected?bgColor:Colors.white,border: Border(bottom: BorderSide(color: Color(0xffE7E7E7),width: 1))),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              height: 10,
            ),
            Text(
              data.name,
              style: TextStyle(
                color: isSelected?Colors.black:Colors.black54,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}