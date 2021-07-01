import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String text;

  const SearchField({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.search,
          size: 30,
          color: Colors.black.withOpacity(0.5),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
            color: Color(0xff030303).withOpacity(0.5),
            fontSize: 10,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
