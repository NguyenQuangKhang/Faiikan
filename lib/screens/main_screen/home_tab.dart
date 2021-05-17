import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/screens/cart_screen/cart_screen.dart';
import 'package:faiikan/screens/main_screen/home_tab_tab/for_you_tab.dart';
import 'package:faiikan/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          onTapCart: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<CartBloc>(),
                        child: CartScreen(
                          person_id: "1",
                        ),
                      );
                    }));
          },
          onTapNotification: () {},
          isRedTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            unselectedLabelColor: Colors.black.withOpacity(0.6),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Container(
                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Cho bạn",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Nam",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Nữ",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Làm đẹp",
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
            ForYouScreen(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
