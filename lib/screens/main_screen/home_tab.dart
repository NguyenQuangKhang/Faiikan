import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
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
                width: MediaQuery.of(context).size.width/4-30,
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
                width: MediaQuery.of(context).size.width/4-30,
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
                width: MediaQuery.of(context).size.width/4-30,
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
                width: MediaQuery.of(context).size.width/4 -30,
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
            MultiBlocProvider(
              child: ForYouScreen(),
              providers: [
                BlocProvider(create: (context) => CategoryBloc(LoadingCategory())..add(InitiateEvent()),),
                BlocProvider(create: (context) => ProductBloc(Initial(data: [],error: "",sortBy: 0))..add(ProductLoadEvent(SortBy: 0)),),
              ],
            ),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
