import 'package:faiikan/widgets/google_and_facebook_login.dart';
import 'package:faiikan/widgets/intput_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height*0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  InputTextField(
                    hintText: "Email",
                    obscure: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    hintText: "Mật khẩu",
                    obscure: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xffF34646),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "Đăng nhập",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Quên mật khẩu?",
                      style: TextStyle(
                          color: Color(0xff40BFFF),
                          fontSize: 15,
                          letterSpacing: 0.5,
                          height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            GoogleAndFacebookLogin(isLogin: true,),
          ],
        ),
      ),
    );
  }
}
