
import 'package:equatable/equatable.dart';
import 'package:faiikan/models/product.dart';



abstract class FavoriteState extends Equatable {
  final List<Product> data;


  FavoriteState({
   required this.data,

  });




  @override
  List<Object> get props => [data];

  @override
  bool get stringify => true;
}


class FavoriteLoadedState extends FavoriteState {
  FavoriteLoadedState({
   required List<Product> data

  }) : super(
      data: data);

  }
  class FavoriteLoaded2State extends FavoriteState {
  FavoriteLoaded2State({
   required List<Product> data

  }) : super(
      data: data);

  }
 class FavoriteLoading extends FavoriteState {
   FavoriteLoading({
   required List<Product> data

  }) : super(
      data: data);

  }

class InitialFavorite extends FavoriteState {
  InitialFavorite({
  required  List<Product> data

  }) : super(
      data: data);

}

