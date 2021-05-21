
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteLoadEvent extends FavoriteEvent {
  final String person_id;

  FavoriteLoadEvent({required this.person_id});
  @override
  List<Object> get props => [person_id];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class FavoriteGetMoreDataEvent extends FavoriteEvent {





  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}

class FavoriteTap extends FavoriteEvent {

  final String person_id;
  final String product_id;
  final int index;



  FavoriteTap({ required this.person_id,required this.product_id,required this.index});
  @override
  List<Object> get props => [person_id,product_id];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
class UpdateWhenTapFavoriteFromDetail extends FavoriteEvent {






  UpdateWhenTapFavoriteFromDetail();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
