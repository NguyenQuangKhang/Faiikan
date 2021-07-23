import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddressState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoadAddress extends AddressState {}


class InitialAddressState extends AddressState {}
class InitiateAddressSuccessfulState extends AddressState {}


class AddSuccessAddress extends AddressState {

}
class UpdateSuccessAddress extends AddressState {

}
class DeleteSuccessAddress extends AddressState {

}