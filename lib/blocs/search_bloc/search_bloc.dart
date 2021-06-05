import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';

import 'package:http/http.dart' as http;

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late List<Product> data;
  int page = 1;

  SearchBloc(SearchState initialState) : super(initialState);
  List<Product> listSearch = [];
  List<String> listHistorySearch = [];

  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is InitiateSearchEvent) {
      yield LoadSearch();
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/${event.userId}/get-history-search"));
      listHistorySearch = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<String>((json) => json["keyword"] as String)
          .toList();
      print(listHistorySearch);
      yield ShowHotSearchState();
    }
    if (event is SearchTextEvent) {
      yield LoadSearch();
      page = 1;
      final response = await http.get(
        Uri.http(
            "$server:8080", "/api/v1/search-product", {
          "s": event.text,
          "p": page.toString(),
        }),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          }
      );
      print(response.body);
      listSearch = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json["productItemDTO"]))
          .toList();
      await http.post(Uri.parse(
          "http://$server:8080/api/v1/${event.userId}/history-search?keyword=${event.text}"));
      listHistorySearch.add(event.text);
      page++;
      yield ShowResultState();
    }
    if (event is LoadMoreSearchEvent) {
      yield LoadMoreSearch();

      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/search-product?s=${event.text}&p=$page"));
      listSearch.addAll(json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Product>((json) => Product.fromJson(json))
          .toList());
      page++;
      yield ShowResultState();
    }
    if(event is ResetSearchEvent)
      {
        yield ShowHotSearchState();
      }
  }
}
