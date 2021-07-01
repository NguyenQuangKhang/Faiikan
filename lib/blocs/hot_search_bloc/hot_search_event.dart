
import 'package:equatable/equatable.dart';

abstract class HotSearchEvent extends Equatable {

}

class InitiateHotSearchEvent extends HotSearchEvent {

  InitiateHotSearchEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}

class LoadMoreHotSearchEvent extends HotSearchEvent {


  LoadMoreHotSearchEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}


