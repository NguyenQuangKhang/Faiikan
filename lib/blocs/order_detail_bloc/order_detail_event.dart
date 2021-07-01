import 'package:equatable/equatable.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

abstract class OrderDetailEvent extends Equatable {}

class InitiateOrderDetailEvent extends OrderDetailEvent {
  final String orderId;

  InitiateOrderDetailEvent({required this.orderId});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class LoadMoreOrderDetailEvent extends OrderDetailEvent {
  final String productId;

  LoadMoreOrderDetailEvent({
    required this.productId,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class CreateReviewEvent extends OrderDetailEvent {
  final String userId;
  final String orderItem;
  final String comment;
  final int star;
  final bool incognito;
  final List<AssetEntity>? listImage;

  CreateReviewEvent(
      {required this.orderItem,
        required this.userId,
      required this.comment,
      required this.incognito,
      required this.listImage,
      required this.star});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}
