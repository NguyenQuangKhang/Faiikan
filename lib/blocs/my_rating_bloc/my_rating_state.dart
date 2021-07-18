import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MyRatingState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadMyRating extends MyRatingState {}
class LoadedMyRating extends MyRatingState {}


class InitialMyRatingState extends MyRatingState {}

class UpdateMyRatingState extends MyRatingState {}



