import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RatingState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadRating extends RatingState {}


class InitialRatingState extends RatingState {}

class ShowRatingState extends RatingState {}

