import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';

import 'package:http/http.dart' as http;

import 'rating_event.dart';
import 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  late Ratings data;
 int page=1;
  RatingBloc(RatingState initialState) : super(initialState);


  RatingState get initialState => InitialRatingState();

  @override
  Stream<RatingState> mapEventToState(
      RatingEvent event,
  ) async* {
    if (event is InitiateRatingEvent) {
//      yield LoadRating();
        page =1;
     final response =   await http.get(Uri.parse("http://$server:8080/api/v1/rating/${event.product_id.toString()}?select=all&p=1"));
     data= Ratings.fromJson(json.decode(response.body));
      yield ShowRatingState();
    }
    if(event is UpdateRatingEvent)
      {
        yield LoadRating();
          page =1;
        final response =   await http.get(Uri.parse("http://$server:8080/api/v1/rating/${event.product_id.toString()}?select=${event.select}&p=${page.toString()}"));
        data = Ratings.fromJson(json.decode(response.body));
        yield ShowRatingState();
      }
    if(event is LoadMoreRatingEvent)
      {
        yield LoadRating();
        page++;
        final response =   await http.get(Uri.parse("http://$server:8080/api/v1/rating/${event.product_id.toString()}?select=${event.select}&p=${page.toString()}"));
        data.listrating.addAll(Ratings.fromJson(json.decode(response.body)).listrating);
        yield ShowRatingState();
      }
  }
}
