import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/product.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/models/search_item.dart';
import 'package:faiikan/utils/server_name.dart';

import 'package:http/http.dart' as http;

import 'hot_search_event.dart';
import 'hot_search_state.dart';

class HotSearchBloc extends Bloc<HotSearchEvent, HotSearchState> {
  late List<Product> data;
  int page = 1;

  HotSearchBloc(HotSearchState initialState) : super(initialState);
  List<SearchItem> listHotSearch=[];

  HotSearchState get initialState => InitialHotSearchState();

  @override
  Stream<HotSearchState> mapEventToState(
    HotSearchEvent event,
  ) async* {
    if (event is InitiateHotSearchEvent) {
      yield LoadHotSearch();

      final response1= await http.get(Uri.parse(
          "http://$server:8080/api/v1/search/hot-search-item?p=$page"));
      listHotSearch = json
          .decode(response1.body)
          .cast<Map<String, dynamic>>()
          .map<SearchItem>((json) => SearchItem.fromJson(json))
          .toList();
      page++;

      yield ShowHotSearchState();
    }
    if (event is LoadMoreHotSearchEvent) {
      yield LoadHotSearch();

      final response= await http.get(Uri.parse(
          "http://$server:8080/api/v1/search/hot-search-item?p=$page"));
      listHotSearch=[];
      listHotSearch = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<SearchItem>((json) => SearchItem.fromJson(json))
          .toList();
      page++;
      yield ShowHotSearchState();
    }
  }
}
