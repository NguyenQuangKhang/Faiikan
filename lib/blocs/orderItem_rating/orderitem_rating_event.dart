import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:faiikan/screens/my_order_screen/update_order_item_rating_screen.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

abstract class OrderItemRatingEvent extends Equatable {}

class InitiateOrderItemRatingEvent extends OrderItemRatingEvent {
  final String person_id;
  final String productId;
  final String productOptionId;

  InitiateOrderItemRatingEvent({required this.person_id, required this.productOptionId,required this.productId,});

  @override
  List<Object> get props => [person_id];

  @override
  String toString() => 'LoginButtonPressed {  }';
}


class UpdateOrderItemRatingEvent extends OrderItemRatingEvent {
  final String ratingId;
  final String comment;
  final String star;
final bool incognito;
final List<CustomFile>? listFiles;

  UpdateOrderItemRatingEvent({
    required this.ratingId,
    required this.comment,
    required this.star,
    required this.incognito,
    required this.listFiles,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}
