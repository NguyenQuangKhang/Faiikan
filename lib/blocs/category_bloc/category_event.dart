import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {}

class CategoryButtonPressed extends CategoryEvent {
  final int parentId;

  CategoryButtonPressed({required this.parentId});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class InitiateEvent extends CategoryEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}