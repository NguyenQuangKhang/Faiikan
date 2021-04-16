import 'package:faiikan/blocs/category_bloc/category_bloc.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/category_bloc/category_state.dart';
import 'package:faiikan/widgets/category1_button.dart';
import 'package:faiikan/widgets/category2_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Color> listBgColors = [
  Color(0xffADDBDE),
  Color(0xffF6A1B5),
  Color(0xffE1B857),
  Color(0xff94C163),
];

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
            color: Colors.white,
            size: 30,
          ),
        ),
        textTheme: TextTheme(),
        title: Center(
          child: Text(
            "Danh mục",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
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
                    child: ListView.builder(
                      itemCount: _categoryBloc.list_cat_1.length,
                      itemBuilder: (context, index) {
                        return Category1Button(
                          onTap: () {
                            _categoryBloc.indexSelected = index;
                            _categoryBloc.add(CategoryButtonPressed(
                                parentId: _categoryBloc.list_cat_1[index].id));
                          },
                          data: _categoryBloc.list_cat_1[index],
                          isSelected: index == _categoryBloc.indexSelected
                              ? true
                              : false,
                          bgColor: listBgColors[index % 3].withOpacity(0.7),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: <Widget>[
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
                              vertical: 5,
                              horizontal: 10,
                            ),
                            color: Color(0xffEBECE9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  _categoryBloc
                                      .list_cat_1[_categoryBloc.indexSelected]
                                      .name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: listBgColors[_categoryBloc.indexSelected % 3]
                                .withOpacity(0.7),
                            padding: EdgeInsets.all(5),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Category2Dropdown(
                                  data: _categoryBloc.sub_cat[index],
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
                              itemCount: _categoryBloc.sub_cat.length,
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
