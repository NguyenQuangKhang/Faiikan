


import 'dart:convert';

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
      final response = await http.get(Uri.parse("http://$server:8080/api/v1/categories/16/sub-categories"));
      list_cat_1 = json.decode(response.body).cast<Map<String,dynamic>>().map<Category>((json) => Category.fromJson(json)).toList();
      final response2= await http.get(Uri.parse("http://$server:8080/api/v1/categories/${list_cat_1[0].id.toString()}/sub-categories"));
      sub_cat = json.decode(response2.body).cast<Map<String,dynamic>>().map<Category>((json) => Category.fromJson(json)).toList();
      yield LoadCategories();

    }


    if(event is CategoryButtonPressed)
    {
      yield LoadingCategory();
      final response = await http.get(Uri.parse("http://$server:8080/api/v1/categories/${event.parentId.toString()}/sub-categories"));
      sub_cat = json.decode(response.body).cast<Map<String,dynamic>>().map<Category>((json) => Category.fromJson(json)).toList();
      yield LoadCategories();
    }
  }
}