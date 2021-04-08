import 'package:faiikan/screens/register_login_screen/login_screen.dart';
import 'package:faiikan/screens/register_login_screen/register_screen.dart';
import 'package:faiikan/widgets/appbar.dart';
import 'package:flutter/material.dart';

class RegisterAndLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          isBack: true,
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            unselectedLabelColor: Colors.black.withOpacity(0.6),
            isScrollable: true,
            tabs: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 35,
                child: Tab(
                  child: Text(
                    "Đăng ký",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 35,
                child: Tab(
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegisterScreen(),
            LoginScreen(),
          ],
        ),
      ),
    );
  }
}
