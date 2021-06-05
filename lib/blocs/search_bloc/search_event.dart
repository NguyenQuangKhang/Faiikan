
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {

}

class InitiateSearchEvent extends SearchEvent {
final String userId;

  InitiateSearchEvent({required this.userId});
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}
class SearchTextEvent extends SearchEvent {
  final String text;
  final String userId;



  SearchTextEvent({required this.text,required this.userId});
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}
class LoadMoreSearchEvent extends SearchEvent {
  final String text;


  LoadMoreSearchEvent({required this.text,});
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}
class DeleteHistorySearchEvent extends SearchEvent {
  final String userId;
  final String hsType;


  DeleteHistorySearchEvent({required this.userId,required this.hsType});
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}
class ResetSearchEvent extends SearchEvent {


  ResetSearchEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LoginButtonPressed {  }';
}