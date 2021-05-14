import 'package:flutter/material.dart';

class ProductPropertyDetail extends StatelessWidget {
  final String firstText;
  final String secondText;

  const ProductPropertyDetail({required this.firstText,required this.secondText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3,child: Text(firstText,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.6)),textAlign: TextAlign.left,)),
          Expanded(flex: 7,child: Text(secondText,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.left,)),

        ],
      ),
    );
  }
}
