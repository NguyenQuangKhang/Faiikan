import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/widgets/category1_button.dart';
import 'package:faiikan/widgets/category2_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Color listBgColors = Color(0xffE7E7E7);

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryBloc _categoryBloc;

  @override
  void initState() {
    _categoryBloc = context.read<CategoryBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
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
      body: BlocBuilder(
          bloc: _categoryBloc,
          builder: (context, state) {
            if (state is LoadingCategory)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.greenAccent,
                ),
              );
            return Stack(children: [
              Row(
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
//                            Navigator.push(context,MaterialPageRoute(
//                                builder: (context)=> BlocProvider<ProductBloc>(
//                                  create: (context){
//                                    return ProductBloc(
//
//                                    )..add(ProductByCategoryCodeEvent(categoryPath: _categoryBloc.list_cat_1[_categoryBloc.indexSelected].categoryPath));
//                                  },
//                                  child:  ProductWithSubCat_Screen(title: _categoryBloc.list_cat_1[_categoryBloc.indexSelected].name, category: _categoryBloc.list_cat_1[_categoryBloc.indexSelected]),
//                                )
//                            )
//                            );
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
                                Text(
                                  _categoryBloc
                                      .list_cat_1[_categoryBloc.indexSelected]
                                      .name,
                                  style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600,letterSpacing: 0.5),
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
                                  data: _categoryBloc.list_cat_1[_categoryBloc.indexSelected].subCategory[index],
                                  onTap: () {
//                                  Navigator.push(context,MaterialPageRoute(
//                                      builder: (context)=> BlocProvider<ProductBloc>(
//                                        create: (context){
//                                          return ProductBloc(
//
//                                          )..add(ProductByCategoryCodeEvent(categoryPath: _categoryBloc.sub_cat[index].categoryPath));
//                                        },
//                                        child:  ProductWithSubCat_Screen(title: _categoryBloc.sub_cat[index].name, category: _categoryBloc.sub_cat[index]),
//                                      )
//                                  )
//                                  );
                                  },
                                  onTapDropdownItem: () {},
                                );
                              },
                              itemCount: _categoryBloc.list_cat_1[_categoryBloc.indexSelected].subCategory.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]);
          }),
    );
  }
}
