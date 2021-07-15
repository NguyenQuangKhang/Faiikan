import 'package:faiikan/widgets/google_and_facebook_login.dart';
import 'package:faiikan/widgets/intput_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController txtName=TextEditingController();
  TextEditingController txtEmail=TextEditingController();
  TextEditingController txtPassword=TextEditingController();
  TextEditingController txtPasswordConfirm=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height*0.8,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all( 15),
              child: Column(
                children: [
                  InputTextField(
                    hintText: "Tên",
                    obscure: false,
                    controller: txtName,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    hintText: "Email",
                    obscure: false,
                    controller: txtEmail,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    hintText: "Mật khẩu",
                    obscure: true,
                    controller: txtPassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    hintText: "Nhập lại mật khẩu",
                    obscure: true,
                    controller: txtPasswordConfirm,
                  ),
                  SizedBox(
                    height: 70,
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
                              "Đăng ký",
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
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            GoogleAndFacebookLogin(onTapLoginFacebook: (){},onTapLoginGoogle:(){} ,),
          ],
        ),
      ),
    );
  }
}
