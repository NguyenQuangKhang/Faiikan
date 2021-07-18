import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class FlashSaleState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadingFlashSale extends FlashSaleState {}
class LoadMoreFlashSale extends FlashSaleState {}


class InitialFlashSaleState extends FlashSaleState {}

class LoadedFlashSaleState extends FlashSaleState {}

class SucessfulGetPeriodState extends FlashSaleState {}


