import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class InputTextField extends StatefulWidget {
  final String hintText;
 bool obscure;
   InputTextField({required this.hintText,this.obscure=false});
  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isHidePassword=true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      obscureText: isHidePassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        border: UnderlineInputBorder(),
        hintText: widget.hintText,
        suffixIcon: widget.obscure?InkWell(onTap: (){
setState(() {
  isHidePassword=!isHidePassword;
});
        },
          child: Icon(isHidePassword? Icons.visibility: Icons.visibility_off),):null,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Color(0xff000000).withOpacity(0.4),
        ),
      ),
    );
  }
}

