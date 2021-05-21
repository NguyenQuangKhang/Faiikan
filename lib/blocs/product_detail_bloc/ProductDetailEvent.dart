




import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}
class ProductDetailLoadEvent extends ProductDetailEvent {
 final int id;
  final String person_id;

  ProductDetailLoadEvent({required this.id, required this.person_id});
  @override
  List<Object> get props => [id,person_id];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
class ProductDetailResetEvent extends ProductDetailEvent {
 final int id;
  final String person_id;

  ProductDetailResetEvent({required this.id, required this.person_id});
  @override
  List<Object> get props => [id,person_id];

  @override
  String toString() =>
      'ProductButtonPressed { ... }';
}
class AddtocartEvent extends ProductDetailEvent {

 final String person_id;
 final String product_id;
 final String option_amount_id;
 final int amount;



 AddtocartEvent({ required this.person_id,required this.product_id,required this.option_amount_id,required this.amount});
 @override
 List<Object> get props => [person_id,product_id,option_amount_id,amount];

 @override
 String toString() =>
     'ProductButtonPressed { ... }';
}


class FavoriteTapEvent extends ProductDetailEvent {

 final String person_id;
 final String product_id;




 FavoriteTapEvent({ required this.person_id,required this.product_id});
 @override
 List<Object> get props => [person_id,product_id];

 @override
 String toString() =>
     'ProductButtonPressed { ... }';
}
