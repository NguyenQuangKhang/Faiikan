import 'dart:convert';
import 'dart:io';

import 'package:faiikan/models/product.dart';
import 'package:faiikan/models/search_item.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ProductEvent.dart';
import 'ProductState.dart';

class ProductBloc extends Bloc<ProductEvent, ProductsState> {
  List<Product> listdata = [];
  int currentPage = 1;
  List<Product> listdataFilter = [];
  int currentPageFilter = 1;
  List<Product> listdataByCategory = [];
  int currentPageByCateGory = 1;
  List<SearchItem> hotSearchItems =[];
  List<Product> listSeenProduct = [];
  ProductBloc(ProductsState initialState) : super(initialState);

  @override
  Stream<ProductsState> mapEventToState(event) async* {
    if (event is ProductLoadEvent) {
      currentPage = 1;
      listdata = [];
//      var param = {'p': 1, 'filter': "popular",};
      yield Loading(
          sortBy: state.sortBy,
          error: "null",
          /* filterRules: null,*/
          data: listdata);
      print("http://$server:8080/api/v1/recommend/top-rating/${event.userId}?p=${currentPage.toString()}");
      final response = await http.get(
          Uri.parse("http://$server:8080/api/v1/recommend/top-rating/${event.userId}?p=${currentPage.toString()}"));


      listdata = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();

      currentPage++;

      if (state is ProductsGridViewState)
        yield ProductsAddmoreState(
            data: listdata, sortBy: event.SortBy, error: '');
      else
        yield ProductsGridViewState(
            data: listdata, sortBy: event.SortBy, error: '');

    }
    if (event is ProductGetMoreDataEvent) {
      // get Products from data.length-1 then add into dat
      yield Loading(sortBy: state.sortBy, error: "", data: listdata);

      final response = await http.get(
          Uri.parse("http://$server:8080/api/v1/recommend/top-rating/${event.userId}?p=${currentPage.toString()}"));

      listdata.addAll(json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList());
      currentPage++;
      if (state is ProductsGridViewState)
        yield ProductsAddmoreState(
            data: listdata, sortBy: event.SortBy, error: '');
      else
        yield ProductsGridViewState(
            data: listdata, sortBy: event.SortBy, error: '');
    }

    if (event is ProductByCategoryCodeEvent) {
      yield Loading(
          sortBy: state.sortBy,
          error: state.error,
//          filterRules: state.filterRules,
          data: state.data);
      print("http://$server:8080/api/v1/cat/${event.categoryId}/products?filter=${event.filter}&p=${currentPageByCateGory.toString()}");
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/cat/${event.categoryId}/products?filter=${event.filter}&p=${currentPageByCateGory.toString()}"));
      listdataByCategory = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      currentPageByCateGory++;

      if (state is ProductsGridViewState)
        yield ProductsAddmoreState(
            data: listdataByCategory, sortBy: state.sortBy, error: '');
      else
        yield ProductsGridViewState(
            data: listdataByCategory, sortBy: state.sortBy, error: '');
    }



    if (event is ProductGetMoreDataByCategoryCodeEvent) {
      yield Loading(
          sortBy: state.sortBy,
          error: state.error,
//          filterRules: state.filterRules,
          data: state.data);
      final response = await http.get(Uri.parse(
          "http://${server}:8080/api/v1/cat/${event.catId}/products?filter=${event.filter}&p=${currentPageByCateGory.toString()}"));
      listdataByCategory.addAll(json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList());
      currentPageByCateGory++;

      if (state is ProductsGridViewState)
        yield ProductsAddmoreState(
            data: listdataByCategory, sortBy: state.sortBy, error: '');
      else
        yield ProductsGridViewState(
            data: listdataByCategory, sortBy: state.sortBy, error: '');
    }

    if(event is SeenProductEvent)
      {
        Loading(
            sortBy: state.sortBy,
            error: state.error,
//          filterRules: state.filterRules,
            data: state.data);
        final response = await http.get(
            Uri.parse("http://$server:8080/api/v1/${event.userId}/get-seen-products"));


        listSeenProduct = json
            .decode(response.body)
            .cast<Map<String, dynamic>>()
            .map<Product>((json) => Product.fromJson(json))
            .toList();



        if (state is ProductsGridViewState)
          yield ProductsAddmoreState(
              data: listdata, sortBy: state.sortBy, error: '');
        else
          yield ProductsGridViewState(
              data: listdata, sortBy: state.sortBy, error: '');
      }
    if (event is RecommendTopRatingEvent) {

    }
  }
}
