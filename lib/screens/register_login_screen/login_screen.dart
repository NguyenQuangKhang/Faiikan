import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountEvent.dart';
import 'package:faiikan/blocs/account_bloc/AccountState.dart';
import 'package:faiikan/screens/main_screen/main_screen.dart';
import 'package:faiikan/widgets/google_and_facebook_login.dart';
import 'package:faiikan/widgets/intput_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: BlocListener(
          bloc: context.read<AccountBloc>(),
          listener: (context, state) {
            if (state is AccountOk)
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<AccountBloc>(),child: MainScreen())));
            if (state is AccountFailure)
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
                        title: Text("Error"),
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
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
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
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      context.read<AccountBloc>().add(
                                          LoginButtonPressed(
                                              username: txtEmail.text,
                                              password: txtPassword.text));
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF34646),
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                      GoogleAndFacebookLogin(
                        isLogin: true,
                      ),
                    ],
                  ),
                  if (state is AccountLoading)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
