import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountEvent.dart';
import 'package:faiikan/blocs/account_bloc/AccountState.dart';
import 'package:faiikan/widgets/google_and_facebook_login.dart';
import 'package:faiikan/widgets/intput_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPasswordConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height*0.8 ,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(15),
          child: BlocListener(
            bloc: context.read<AccountBloc>(),
            listener: (context, state) {
              if (state is RegisterOk) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          actions: [
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          title: Text("Thành công"),
                          content: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Đăng ký thành công!"),
                            ),
                          ),
                        ));
              }
              if (state is RegisterFailure)
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          actions: [
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          title: Text("Lỗi"),
                          content: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(state.error),
                            ),
                          ),
                        ));
            },
            child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            InputTextField(
                              hintText: "Tên",
                              obscure: false,
                              controller: txtName,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Không được để trống phần này";
                                else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              hintText: "Email",
                              obscure: false,
                              controller: txtEmail,
                              validator: (value) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!))
                                  return null;
                                else
                                  return "Vui lòng nhập đúng định dạng email.";
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              hintText: "Mật khẩu",
                              obscure: true,
                              controller: txtPassword,
                              validator: (value) {
                                if (value!.length < 6)
                                  return "Password phải có ít nhất 6 kí tự";
                                else if (value != txtPasswordConfirm.text && txtPasswordConfirm.text.isNotEmpty) {
                                  return "Mật khẩu không trùng khớp.";
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              hintText: "Nhập lại mật khẩu",
                              obscure: true,
                              controller: txtPasswordConfirm,
                              validator: (value) {
                                if (value!.length < 6)
                                  return "Password phải có ít nhất 6 kí tự";
                                else if (value != txtPassword.text) {
                                  return "Mật khẩu không trùng khớp.";
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if(txtName.text.isNotEmpty && txtPasswordConfirm.text ==txtPassword.text && txtPassword.text.length >=6 && RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(txtEmail.text) )
                                      context.read<AccountBloc>().add(
                                          RegisterEvent(
                                              username: txtName.text,
                                              password: txtPassword.text,
                                              name: txtName.text));
                                      else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("Vui lòng nhập đúng các điều kiện.")),duration: Duration(seconds: 2),),);
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF34646),
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      GoogleAndFacebookLogin(
                        onTapLoginFacebook: () {},
                        onTapLoginGoogle: () {},
                      ),
                    ],
                  ),
                  if (state is AccountLoading)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent,
                      ),
                    )
                ],
              );
            }),
          ),
        ));
  }
}
