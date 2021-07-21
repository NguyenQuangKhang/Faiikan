import 'dart:async';

import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountEvent.dart';
import 'package:faiikan/blocs/account_bloc/AccountState.dart';
import 'package:faiikan/screens/main_screen/main_screen.dart';
import 'package:faiikan/screens/sex_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future startTime() async {
    const _duration = Duration(seconds: 2);
    return Timer(_duration, _navigationPage);
  }

  Future _navigationPage() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("catId") == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SexSelectScreen()));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) =>
              AccountBloc(AccountInitial())..add(InitialAccount()),
              child: MainScreen(),
            ),
          ));
    }
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,),),
        ));
  }
}
