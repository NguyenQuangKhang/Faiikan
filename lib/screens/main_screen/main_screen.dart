import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountState.dart';
import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteBloc.dart';
import 'package:faiikan/blocs/favorite_bloc/FavoriteEvent.dart';
import 'package:faiikan/blocs/favorite_bloc/FavortieState.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/screens/main_screen/category_tab.dart';
import 'package:faiikan/screens/main_screen/favorite_tab.dart';
import 'package:faiikan/screens/main_screen/home_tab.dart';
import 'package:faiikan/screens/main_screen/profile_tab.dart';
import 'package:faiikan/screens/post_screen/post_explorer.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_screen/message_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  var tab;

  @override
  void initState() {
    tab = [
     MultiBlocProvider(
        providers: [


          BlocProvider(
            create: (BuildContext context) =>
                CartBloc(InitialCart(data: [], discount: 0, totalPrice: 0))
                  ..add(GetCartEvent(
                      person_id:
                      context.read<AccountBloc>().userId==0?"0":context.read<AccountBloc>().user!.id!.toString())),
          ),

//          BlocProvider<ProductDetailBloc>(
//            create: (BuildContext context) {
//              return ProductDetailBloc(InitialProductDetail());
//            },
//          ),
        ],
        child: HomeScreen(),
      ),


      BlocProvider(
          create: (_) => CategoryBloc( LoadingCategory())..add(InitiateEvent(catId: 16)),
          child: BlocProvider(
            create: (BuildContext context) =>
            CartBloc(InitialCart(data: [], discount: 0, totalPrice: 0))
              ..add(GetCartEvent(
                  person_id:
                  context.read<AccountBloc>().userId==0?"0":context.read<AccountBloc>().user!.id!.toString())),
            child: CategoryScreen(userId: context.read<AccountBloc>().userId==0?0:context
                .read<AccountBloc>()
                .user!
                .id!,),
          )),
      BlocProvider.value(value: context.read<AccountBloc>(),child: MessageScreen()),
//      PostExplorer(),

      MultiBlocProvider(
        providers: [
           BlocProvider(
            create: (BuildContext context) =>
                CartBloc(InitialCart(data: [], discount: 0, totalPrice: 0))
                  ..add(GetCartEvent(
                      person_id:
                          context.read<AccountBloc>().user!.id!.toString())),
          ),
          BlocProvider.value(value: context.read<AccountBloc>()),
          BlocProvider(
            create: (BuildContext context) =>
                ProductBloc(InitialProductState(data: [], error: "", sortBy: 0))
                  ..add(ProductLoadEvent(
                      SortBy: 0, userId: context.read<AccountBloc>().userId==0?0:context.read<AccountBloc>().user!.id!)),
          ),
        ],
        child: ProfileScreen(
          userId: context.read<AccountBloc>().user!.id!,
        ),
      )
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc,AccountState>(

      builder: (context,state) => DefaultTabController(
        length: 4,
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
//              BottomNavigationBarItem(
//                icon: Icon(Icons.explore),
//                title: Text("Bài viết"),
//                backgroundColor: Color(0xffF05A5A),
//              ),
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
      ),
    );
  }
}
