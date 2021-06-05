import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountState.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_event.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_state.dart';
import 'package:faiikan/screens/address_screen/my_address.dart';
import 'package:faiikan/screens/cart_screen/cart_screen.dart';
import 'package:faiikan/screens/main_screen/main_screen.dart';
import 'package:faiikan/screens/my_order_screen/my_order_screen.dart';
import 'package:faiikan/screens/payment_screen/payment_screen.dart';
import 'package:faiikan/screens/register_login_screen/register_and_login_screen.dart';
import 'package:faiikan/screens/review_screen/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/address_bloc/address_bloc.dart';
import 'blocs/address_bloc/address_event.dart';
import 'blocs/address_bloc/address_state.dart';
import 'screens/register_login_screen/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:
          /*BlocProvider(
        create: (_) => AddressBloc(InitialAddressState())
          ..add(GetProvinceEvent()),
        child: MyAddressScreen(),
      ),*/
          BlocProvider(
        create: (BuildContext context) => AccountBloc(AccountInitial()),
        child: RegisterAndLoginScreen(),
      ),
      /*MainScreen()*/
      /*BlocProvider(
        create: (BuildContext context) => MyOrderBloc(InitialMyOrderState())..add(InitiateEvent(person_id: "person_id")),
        child: MyOrderScreen(),
      ),*/
      /*BlocProvider(
        create: (BuildContext context) =>
            CartBloc(Initial(data: [], discount: 0, totalPrice: 0))
              ..add(GetCartEvent(person_id: "person_id")),
        child: CartScreen(
          person_id: "1",
        ),
      ),*/
    );
  }
}
