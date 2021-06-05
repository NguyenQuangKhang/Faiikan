import 'package:equatable/equatable.dart';
import 'package:faiikan/models/address.dart';

abstract class AddressEvent extends Equatable {}

class GetProvinceEvent extends AddressEvent {
  GetProvinceEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class GetDistrictEvent extends AddressEvent {
  final String provinceId;

  GetDistrictEvent({required this.provinceId});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class GetWardEvent extends AddressEvent {
  final String districtId;

  GetWardEvent({required this.districtId});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}
class InitialAddressEvent extends AddressEvent {
  final String userId;

  InitialAddressEvent({required this.userId});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class AddNewAddressEvent extends AddressEvent {
  final String userId;
  final  String name;
  final  String numberPhone;
  final  String specificAddress;
  final bool defaultIs;
  final  String ward;
  AddNewAddressEvent({required this.userId,required this.name,required this.specificAddress,required this.numberPhone,required this.defaultIs,required this.ward});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class UpdateAddressEvent extends AddressEvent {
  final String addressId;
  final  String name;
  final  String numberPhone;
  final  String specificAddress;
  final bool defaultIs;
  final  String ward;
  UpdateAddressEvent({required this.addressId,required this.name,required this.specificAddress,required this.numberPhone,required this.defaultIs,required this.ward});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}

class ChooseUnitAddressEvent extends AddressEvent {
  final int index;
  final String type;

  ChooseUnitAddressEvent({required this.index,required this.type});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed {  }';
}