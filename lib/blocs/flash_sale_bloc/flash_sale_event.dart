
import 'package:equatable/equatable.dart';

abstract class FlashSaleEvent extends Equatable {

}

class InitiateFlashSaleEvent extends FlashSaleEvent {


  InitiateFlashSaleEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

class LoadProductOfPeriod extends FlashSaleEvent {
final int id;

  LoadProductOfPeriod({required this.id});
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}
class LoadMoreProductOfPeriod extends FlashSaleEvent {

final int id;

  LoadMoreProductOfPeriod({required this.id});

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

class ResetFlashSaleEvent extends FlashSaleEvent {


  ResetFlashSaleEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}