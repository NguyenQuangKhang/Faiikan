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
        color: isSelected?bgColor:Colors.white,
        height: MediaQuery.of(context).size.height / 6,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.network(
                data.icon,
                fit: BoxFit.fill,
//                color: isSelected?Colors.red: null,
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Text(
                data.name,
                style: TextStyle(
                  color: isSelected?Colors.black:Colors.black54,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if(!isSelected) Container(
              height: 1,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }
}