import 'dart:convert';
import 'dart:io';

import 'package:faiikan/models/product.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ProductEvent.dart';
import 'ProductState.dart';

class ProductBloc extends Bloc<ProductEvent, ProductsState> {
  List<Product> listdata = [];
  int currentPage = 1;
  List<Product> listRecommendTopRating=[];
  List<Product> listdataFilter = [];
  int currentPageFilter = 1;
  List<Product> listdataByCategory = [];
  int currentPageByCateGory = 1;

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
      final response1 = await http.get(Uri.parse(
          "http://$server:8080/api/v1/recommend/top-rating/67493"));
      listRecommendTopRating = json
          .decode(response1.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      final response = await http.get(
          Uri.parse(
            "http://$server:8080/api/v1/cat/20/products?p=${currentPage.toString()}&filter=popular",
          ),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
      print(response.body);
      listdata =
          json.decode(response.body).cast<Map<String, dynamic>>().map<Product>((
              json) => Product.fromJson(json)).toList();
      print(listdata);
      currentPage++;

      if (state is ProductsGridViewState)
        yield ProductsAddmoreState(
            data: listdata, sortBy: event.SortBy, error: '');
      else
        yield ProductsGridViewState(
            data: listdata, sortBy: event.SortBy, error: '');

//      print("Productgetmoredata event");    if (event is ProductGetMoreDataEvent) {
////      // get Products from data.length-1 then add into dat
//      yield Loading(
//          sortBy: state.sortBy, error: null, filterRules: null, data: listdata);
//      QueryResult result = await _client
//          .query(QueryOptions(documentNode: gql(getProduct), variables: {
//        "pageNumber": currentPage,
//        "sort": event.SortBy == null ? state.sortBy : event.SortBy
//      }));
//      if (!result.hasException) {
//        List<LazyCacheMap> list_to_add =
//            (result.data["getProduct"]["products"] as List<dynamic>)
//                .cast<LazyCacheMap>();
//
//        for (int i = 0; i < list_to_add.length; i++) {
//          listdata.add(new Product(
//              list_to_add[i]["_id"],
//              list_to_add[i]["name"],
//              list_to_add[i]["img_url"],
//              list_to_add[i]["price"],
//              list_to_add[i]["promotion_percent"],
//              list_to_add[i]["final_price"],
//              null,
//              list_to_add[i]["stock_status"],
//              list_to_add[i]["record_status"]));
//        }
//        currentPage++;
//      }

    }

    if (event is ProductByCategoryCodeEvent) {
      yield Loading(
          sortBy: state.sortBy,
          error: state.error,
//          filterRules: state.filterRules,
          data: state.data);
      final response = await http.get(Uri.parse(
          "http://${server}:8080api/v1/cat/${event.categoryPath}/products?p=${currentPageByCateGory.toString()}"));
      listdataByCategory = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList();
//      QueryResult result = await _client.query(
//          QueryOptions(documentNode: gql(getProductByCategory), variables: {
//        "level_code": event.category_code,
//        "pageNumber": currentPageByCateGory,
//        "colors": [],
//        "sizes": [],
//        "price_min": 0,
//        "price_max": 0,
//        "sort": state.sortBy
//      }));
//
//      if (!result.hasException) {
//        List<LazyCacheMap> list_to_add =
//            (result.data["getProductByCategory"] as List<dynamic>)
//                .cast<LazyCacheMap>();
//
//        for (int i = 0; i < list_to_add.length; i++) {
//          listdataByCategory.add(new Product(
//              list_to_add[i]["_id"],
//              list_to_add[i]["name"],
//              list_to_add[i]["img_url"],
//              list_to_add[i]["price"],
//              list_to_add[i]["promotion_percent"],
//              list_to_add[i]["final_price"],
//              null,
//              list_to_add[i]["stock_status"],
//              list_to_add[i]["record_status"]));
//        }
//        currentPageByCateGory++;
//      }

          if (state is ProductsGridViewState)
      yield
      ProductsAddmoreState(
          data: listdataByCategory, sortBy: state.sortBy, error: '');
    else
      yield ProductsGridViewState(
          data: listdataByCategory, sortBy: state.sortBy, error: '');
  }

//    if (event is FilterandSortByEvent) {
//      print(event.SortBy);
//      QueryResult result;
//
//      yield Loading(
//          sortBy: state.sortBy,
//          error: state.error,
//          filterRules: state.filterRules,
//          data: state.data);
////      if (event.filter != null) {
////        currentPageFilter = 1;
////        listdataFilter = [];
////
////        result = await _client.query(
////            QueryOptions(documentNode: gql(getProductByCategory), variables: {
////          "level_code": event.filter.level_code,
////          "pageNumber": currentPageFilter,
////          "colors": event.filter.colorID,
////          "sizes": event.filter.sizeID,
////          "price_min": event.filter.min_price,
////          "price_max": event.filter.max_price,
////          "sort": event.SortBy == null ? state.sortBy : event.SortBy
////        }));
////      } else {
////        currentPageFilter = 1;
////        listdataFilter = [];
////        result = await _client.query(
////            QueryOptions(documentNode: gql(getProductByCategory), variables: {
////          "level_code": event.level_code,
////          "pageNumber": currentPageFilter,
////          "colors": state.filterRules == null ? [] : state.filterRules.colorID,
////          "sizes": state.filterRules == null ? [] : state.filterRules.sizeID,
////          "price_min":
////              state.filterRules == null ? 0 : state.filterRules.min_price,
////          "price_max":
////              state.filterRules == null ? 0 : state.filterRules.max_price,
////          "sort": event.SortBy == null ? state.sortBy : event.SortBy
////        }));
////      }
////
////      if (!result.hasException) {
////        List<LazyCacheMap> list_to_add =
////            (result.data["getProductByCategory"] as List<dynamic>)
////                .cast<LazyCacheMap>();
////
////        for (int i = 0; i < list_to_add.length; i++) {
////          listdataFilter.add(new Product(
////              list_to_add[i]["_id"],
////              list_to_add[i]["name"],
////              list_to_add[i]["img_url"],
////              list_to_add[i]["price"],
////              list_to_add[i]["promotion_percent"],
////              list_to_add[i]["final_price"],
////              null,
////              list_to_add[i]["stock_status"],
////              list_to_add[i]["record_status"]));
////        }
////        currentPageFilter++;
////      }
//      if (state is ProductsGridViewState)
//        yield ProductsAddmoreState(
//            filterRules:
//                event.filter == null ? state.filterRules : event.filter,
//            data: listdataFilter,
//            sortBy: event.SortBy == null ? state.sortBy : event.SortBy);
//      else
//        yield ProductsGridViewState(
//            filterRules:
//                event.filter == null ? state.filterRules : event.filter,
//            data: listdataFilter,
//            sortBy: event.SortBy == null ? state.sortBy : event.SortBy);
//    }

//    if (event is ProductGetMoreDataByCategoryCodeEvent) {
//      QueryResult result;
//
//      yield Loading(
//          sortBy: state.sortBy,
//          error: state.error,
//          filterRules: state.filterRules,
//          data: state.data);
////      if (event.filter != null) {
////        result = await _client.query(
////            QueryOptions(documentNode: gql(getProductByCategory), variables: {
////          "level_code": event.filter.level_code,
////          "pageNumber": currentPageFilter,
////          "colors": state.filterRules == null ? [] : state.filterRules.colorID,
////          "sizes": state.filterRules == null ? [] : state.filterRules.sizeID,
////          "price_min":
////              state.filterRules == null ? 0 : state.filterRules.min_price,
////          "price_max":
////              state.filterRules == null ? 0 : state.filterRules.max_price,
////          "sort": event.SortBy == null ? state.sortBy : event.SortBy
////        }));
////      } else {
////        currentPageFilter = 1;
////        listdataFilter = [];
////        result = await _client.query(
////            QueryOptions(documentNode: gql(getProductByCategory), variables: {
////          "level_code": event.level_code,
////          "pageNumber": currentPageFilter,
////          "colors": [],
////          "sizes": [],
////          "price_min": 0,
////          "price_max": 0,
////          "sort": event.SortBy == null ? state.sortBy : event.SortBy
////        }));
////      }
////
////      if (!result.hasException) {
////        List<LazyCacheMap> list_to_add =
////            (result.data["getProductByCategory"] as List<dynamic>)
////                .cast<LazyCacheMap>();
////
////        for (int i = 0; i < list_to_add.length; i++) {
////          listdataFilter.add(new Product(
////              list_to_add[i]["_id"],
////              list_to_add[i]["name"],
////              list_to_add[i]["img_url"],
////              list_to_add[i]["price"],
////              list_to_add[i]["promotion_percent"],
////              list_to_add[i]["final_price"],
////              null,
////              list_to_add[i]["stock_status"],
////              list_to_add[i]["record_status"]));
////        }
////        currentPageFilter++;
////      }
//      if (state is ProductsGridViewState)
//        yield ProductsAddmoreState(
//            filterRules:
//                event.filter == null ? state.filterRules : event.filter,
//            data: listdataFilter,
//            sortBy: event.SortBy == null ? state.sortBy : event.SortBy);
//      else
//        yield ProductsGridViewState(
//            filterRules:
//                event.filter == null ? state.filterRules : event.filter,
//            data: listdataFilter,
//            sortBy: event.SortBy == null ? state.sortBy : event.SortBy);
//    }
  if(event is RecommendTopRatingEvent)
    {

    }
    }
}
