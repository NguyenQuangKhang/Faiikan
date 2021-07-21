import 'package:auto_size_text/auto_size_text.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/models/category.dart';
import 'package:faiikan/screens/product_screen/ProductWithCatLv3_Screen.dart';
import 'package:faiikan/widgets/category1_button.dart';
import 'package:faiikan/widgets/category2_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Color listBgColors = Color(0xffE7E7E7);

class CategoryScreen extends StatefulWidget {
  final int userId;
  bool isBack;

   CategoryScreen({required this.userId,this.isBack=false});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late CategoryBloc _categoryBloc;
  late TabController controller;

  @override
  void initState() {
    _categoryBloc = context.read<CategoryBloc>();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      print(controller.index);
      if (controller.index == 0) _categoryBloc.add(InitiateEvent(catId: 16));
      if (controller.index == 1) _categoryBloc.add(InitiateEvent(catId: 17));
      if (controller.index == 2) _categoryBloc.add(InitiateEvent(catId: 324));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(centerTitle: true,
          leading: widget.isBack?GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ):Container(),
          textTheme: TextTheme(),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Danh mục",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        backgroundColor: Color(0xffE7E7E7),
        body:  Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(indicatorColor: Colors.black,controller: controller, tabs: [
                      Container(
//                width: MediaQuery.of(context).size.width / 4 - 30,
                        child: Tab(
                          child: Text(
                            "Nam",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.5,
                                color: Colors.black),
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
                                color: Colors.black),
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
                                color: Colors.black),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: TabBarView(controller: controller, children: [
//                      BlocProvider.value(value: context.read<CategoryBloc>()..add(InitiateEvent(catId: 16)),child: CategoryTabView(userId: widget.userId)),
//                        BlocProvider.value(value: context.read<CategoryBloc>()..add(InitiateEvent(catId: 17)),child: CategoryTabView(userId: widget.userId)),
//                        BlocProvider.value(value: context.read<CategoryBloc>()..add(InitiateEvent(catId: 324)),child: CategoryTabView(userId: widget.userId)),
                      BlocProvider.value(value:context.read<AccountBloc>(),child: CategoryTabView(userId: widget.userId)),
                      CategoryTabView(userId: widget.userId),
                      CategoryTabView(userId: widget.userId),
                    ]),
                  ),
                ],
              )

      ),
    );
  }
}

class CategoryTabView extends StatefulWidget {
  final int userId;

  const CategoryTabView({Key? key, required this.userId}) : super(key: key);

  @override
  _CategoryTabViewState createState() => _CategoryTabViewState();
}

class _CategoryTabViewState extends State<CategoryTabView> {
  late CategoryBloc _categoryBloc;

  @override
  void initState() {
    _categoryBloc = context.read<CategoryBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _categoryBloc,
    builder: (context, state) {
    if (state is LoadingCategory)
    return Center(
    child: CircularProgressIndicator(
    backgroundColor: Colors.greenAccent,
    ),
    );
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: _categoryBloc.list_cat_1.length,
                        itemBuilder: (context, index) {
                          return Category1Button(
                            onTap: () {
                              setState(() {
                                _categoryBloc.indexSelected = index;
                              });
                            },
                            data: _categoryBloc.list_cat_1[index],
                            isSelected: index == _categoryBloc.indexSelected
                                ? true
                                : false,
                            bgColor: listBgColors,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 5,
                          color: listBgColors,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) {
                                      return ProductBloc(
                                        InitialProductState(
                                          data: [],
                                          error: "",
                                          sortBy: 0,
                                        ),
                                      )..add(ProductByCategoryCodeEvent(
                                          categoryId: _categoryBloc
                                              .list_cat_1[
                                                  _categoryBloc.indexSelected]
                                              .id
                                              .toString(),
                                          filter: "popular"));
                                    },
                                    child: BlocProvider.value(
                                      value: context.read<AccountBloc>(),
                                      child: BlocProvider.value(
                                          value: context.read<CartBloc>(),
                                          child: ProductWithSubCat_Screen(
                                              userId: widget.userId,
                                              title: _categoryBloc
                                                  .list_cat_1[
                                                      _categoryBloc.indexSelected]
                                                  .name,
                                              category: _categoryBloc.list_cat_1[
                                                  _categoryBloc.indexSelected])),
                                    ),
                                  ),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
//                            margin: EdgeInsets.only(left: 5),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _categoryBloc
                                        .list_cat_1[_categoryBloc.indexSelected]
                                        .name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Xem tất cả",
                                      style: TextStyle(
                                        color: Color(0xff0C73D2),
                                        fontSize: 10,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: Color(0xff0C73D2),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: listBgColors,
                            padding: EdgeInsets.all(5),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Category2Dropdown(
                                  userId: widget.userId,
                                  data: _categoryBloc
                                      .list_cat_1[_categoryBloc.indexSelected]
                                      .subCategory[index],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              BlocProvider(
                                            create: (_) {
                                              return ProductBloc(
                                                InitialProductState(
                                                  data: [],
                                                  error: "",
                                                  sortBy: 0,
                                                ),
                                              )..add(ProductByCategoryCodeEvent(
                                                  categoryId: _categoryBloc
                                                      .list_cat_1[_categoryBloc
                                                          .indexSelected]
                                                      .subCategory[index]
                                                      .id
                                                      .toString(),
                                                  filter: "popular"));
                                            },
                                            child: BlocProvider.value(
                                                value: context.read<CartBloc>(),
                                                child: BlocProvider.value(
                                                  value: context.read<AccountBloc>(),
                                                  child: ProductWithSubCat_Screen(
                                                      userId: widget.userId,
                                                      title: _categoryBloc
                                                          .list_cat_1[
                                                              _categoryBloc
                                                                  .indexSelected]
                                                          .subCategory[index]
                                                          .name,
                                                      category: new Category(
                                                        id: _categoryBloc
                                                            .list_cat_1[
                                                                _categoryBloc
                                                                    .indexSelected]
                                                            .subCategory[index]
                                                            .id,
                                                        name: _categoryBloc
                                                            .list_cat_1[
                                                                _categoryBloc
                                                                    .indexSelected]
                                                            .subCategory[index]
                                                            .name,
                                                        icon: _categoryBloc
                                                            .list_cat_1[
                                                                _categoryBloc
                                                                    .indexSelected]
                                                            .subCategory[index]
                                                            .icon,
                                                        level: _categoryBloc
                                                            .list_cat_1[
                                                                _categoryBloc
                                                                    .indexSelected]
                                                            .subCategory[index]
                                                            .level,
                                                        subCat: _categoryBloc
                                                            .list_cat_1[
                                                                _categoryBloc
                                                                    .indexSelected]
                                                            .subCategory[index]
                                                            .subCategory,
                                                      )),
                                                )),
                                          ),
                                        ));
                                  },
                                  onTapDropdownItem: () {},
                                );
                              },
                              itemCount: _categoryBloc
                                  .list_cat_1[_categoryBloc.indexSelected]
                                  .subCategory
                                  .length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
//          if(state is LoadingCategory)
//            Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,))
      ],
    );
  }

);

  }
}
