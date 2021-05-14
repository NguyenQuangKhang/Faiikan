


import 'package:faiikan/models/category.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<Category> list_cat_1 = [];
  List<Category> sub_cat = [];

  int indexSelected=0;

  CategoryBloc(CategoryState initialState) : super(initialState);

  CategoryState get initialState => LoadingCategory();

  @override
  Stream<CategoryState> mapEventToState(
      CategoryEvent event,
      ) async* {
    if (event is InitiateEvent) {
      yield LoadingCategory();
//      final response = await http.get(Uri.http(server,'''/api/v1/categories/16/sub-categories'''));

      list_cat_1 = [new Category(id: 1, level: 1, name: "Quần áo", icon: "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg", categoryPath: "categoryPath"),new Category(id: 1, level: 1, name: "Quần áo", icon: "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg", categoryPath: "categoryPath"),new Category(id: 1, level: 1, name: "Quần áo", icon: "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg", categoryPath: "categoryPath"),new Category(id: 1, level: 1, name: "Quần áo", icon: "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg", categoryPath: "categoryPath"),
        new Category(
            id: 1,
            level: 1,
            name: "Giày dép",
            icon:
                "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
            categoryPath: "categoryPath"),
        new Category(
            id: 1,
            level: 1,
            name: "Đồng hồ",
            icon:
                "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
            categoryPath: "categoryPath"),
        new Category(
            id: 1,
            level: 1,
            name: "Túi xách",
            icon:
                "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
            categoryPath: "categoryPath"),
      ];

      sub_cat = [ new Category(
          id: 1,
          level: 1,
          name: "Áo khoác",
          icon:
          "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
          categoryPath: "categoryPath"),new Category(
          id: 1,
          level: 1,
          name: "Áo khoác",
          icon:
          "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
          categoryPath: "categoryPath"),new Category(
          id: 1,
          level: 1,
          name: "Áo khoác",
          icon:
          "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
          categoryPath: "categoryPath"),new Category(
          id: 1,
          level: 1,
          name: "Áo khoác",
          icon:
          "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
          categoryPath: "categoryPath"),new Category(
          id: 1,
          level: 1,
          name: "Áo khoác",
          icon:
          "https://media3.scdn.vn/images/ecom/category/1666_simg_3a7818_100x100_maxb.jpg",
          categoryPath: "categoryPath"),];
//      final response = await   http.get("http://10.0.206.16:8080/api/v1/categories?level=1");
//      list_cat_1 = json.decode(response.body).cast<Map<String,dynamic>>().map<Category>((json) => Category.fromJson(json)).toList();
//      final response2= await http.get("http://10.0.206.16:8080/api/v1/categories/"+list_cat_1[0].id.toString()+ "/sub-categories");
//      sub_cat = json.decode(response2.body).cast<Map<String,dynamic>>().map<Category>((json) => Category.fromJson(json)).toList();
      yield LoadCategories();

    }


    if(event is CategoryButtonPressed)
    {
      yield LoadingCategory();
//      final response = await http.get("http://10.0.206.16:8080/api/v1/categories/"+event.parentId.toString()+ "/sub-categories");
//      sub_cat = json.decode(response.body).cast<Map<String,dynamic>>().map<Category>((json) => Category.fromJson(json)).toList();
      yield LoadCategories();
    }
  }
}