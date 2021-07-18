import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/blocs/flash_sale_bloc/flash_sale_bloc.dart';
import 'package:faiikan/blocs/flash_sale_bloc/flash_sale_event.dart';
import 'package:faiikan/blocs/flash_sale_bloc/flash_sale_state.dart';
import 'package:faiikan/blocs/hot_search_bloc/hot_search_bloc.dart';
import 'package:faiikan/blocs/hot_search_bloc/hot_search_event.dart';
import 'package:faiikan/blocs/hot_search_bloc/hot_search_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/screens/cart_screen/cart_screen.dart';
import 'package:faiikan/screens/main_screen/home_tab_tab/for_you_tab.dart';
import 'package:faiikan/screens/main_screen/home_tab_tab/male_screen.dart';
import 'package:faiikan/screens/register_login_screen/register_and_login_screen.dart';
import 'package:faiikan/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_tab_tab/beauty_screen.dart';
import 'home_tab_tab/female_screen.dart';

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
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return /*context.read<AccountBloc>().userId==0?BlocProvider.value(value: context.read<AccountBloc>(),child: RegisterAndLoginScreen(initialIndex: 1,),):*/BlocProvider.value(
                value: context.read<CartBloc>(),
                child: BlocProvider.value(value: context.read<AccountBloc>(),
                  child: BlocProvider(create: (_) =>ProductBloc(InitialProductState(data: [], error: "", sortBy: 0))
                    ..add(ProductLoadEvent(
                        SortBy: 0, userId: context.read<AccountBloc>().userId==0?0:context.read<AccountBloc>().user!.id!)),
                    child: CartScreen(
                      person_id: context.read<AccountBloc>().user!.id!,
                    ),
                  ),
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
//                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Cho bạn",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              Container(
//                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Nam",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              Container(
//                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Nữ",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              Container(
//                width: MediaQuery.of(context).size.width / 4 - 30,
                child: Tab(
                  child: Text(
                    "Làm đẹp",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MultiBlocProvider(providers: [
              BlocProvider(
                create: (BuildContext context) =>
                ProductBloc(InitialProductState(data: [], error: "", sortBy: 0))
                  ..add(ProductLoadEvent(
                      SortBy: 0, userId: context.read<AccountBloc>().userId==0?0:context.read<AccountBloc>().user!.id!)),
              ),
              BlocProvider(create: (_) => FlashSaleBloc(InitialFlashSaleState())..add(InitiateFlashSaleEvent()),),
              BlocProvider(
                create: (_) => HotSearchBloc(LoadHotSearch())
                  ..add(InitiateHotSearchEvent()),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    CategoryBloc(LoadingCategory())
                      ..add(InitiateEvent(catId: 16)),
              ),

            ], child: ForYouScreen()),

            MultiBlocProvider(providers: [
              BlocProvider(create: (BuildContext context) =>
              ProductBloc(InitialProductState(data: [], error: "", sortBy: 0))..add(ProductByCategoryCodeEvent(filter: "popular",categoryId: "16")),),
              BlocProvider(
                create: (BuildContext context) =>
                CategoryBloc(LoadingCategory())
                  ..add(InitiateEvent(catId: 16)),
              ),
            ], child: MaleScreen()),
            MultiBlocProvider(providers: [
              BlocProvider(create: (BuildContext context) =>
              ProductBloc(InitialProductState(data: [], error: "", sortBy: 0))..add(ProductByCategoryCodeEvent(filter: "popular",categoryId: "17")),),
              BlocProvider(
                create: (BuildContext context) =>
                CategoryBloc(LoadingCategory())
                  ..add(InitiateEvent(catId: 17)),
              ),
            ], child: FemaleScreen()),
            MultiBlocProvider(providers: [
              BlocProvider(create: (BuildContext context) =>
              ProductBloc(InitialProductState(data: [], error: "", sortBy: 0))..add(ProductByCategoryCodeEvent(filter: "popular",categoryId: "324")),),
              BlocProvider(
                create: (BuildContext context) =>
                CategoryBloc(LoadingCategory())
                  ..add(InitiateEvent(catId: 324)),
              ),
            ], child: BeautyScreen()),
          ],
        ),
      ),
    );
  }
}
