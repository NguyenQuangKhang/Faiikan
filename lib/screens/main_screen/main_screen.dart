import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/screens/main_screen/category_tab.dart';
import 'package:faiikan/screens/main_screen/favorite_tab.dart';
import 'package:faiikan/screens/main_screen/home_tab.dart';
import 'package:faiikan/screens/main_screen/message_tab.dart';
import 'package:faiikan/screens/main_screen/profile_tab.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final tab = [
    HomeScreen(),
    BlocProvider(
      child: CategoryScreen(),
      create: (BuildContext context) => CategoryBloc(LoadingCategory())..add(InitiateEvent()),
    ),
    MessageScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 0,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFF05A5A),
          unselectedFontSize: 14,
          unselectedIconTheme: IconThemeData(size: 20, color: Colors.black54),
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Trang chủ"),
              backgroundColor: Color(0xffF05A5A),
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.category),
              title: Text("Danh mục"),
              backgroundColor: Color(0xffF05A5A),
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.message),
              title: Text("Tin nhắn"),
              backgroundColor: Color(0xffF05A5A),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Yêu thích"),
              backgroundColor: Color(0xffF05A5A),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Tôi"),
              backgroundColor: Color(0xffF05A5A),
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        body: tab[currentIndex],
      ),
    );
  }
}
