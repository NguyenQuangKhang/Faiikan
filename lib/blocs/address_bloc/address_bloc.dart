import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:faiikan/models/address.dart';
import 'package:faiikan/models/order.dart';
import 'package:faiikan/models/order_item.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:http/http.dart' as http;

import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  List<Province> provinces = [];
  List<District> districts = [];
  List<Ward> wards = [];
  List<Address> myAddresses = [];
  int? selectedProvice;
  int? selectedDistric;
  int? selectedWard;
  AddressBloc(AddressState initialState) : super(initialState);

  @override
  AddressState get initialState => InitialAddressState();

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is InitialAddressEvent) {
      yield LoadAddress();
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/user/${event.userId}/get-addresses"));
      myAddresses = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Address>((json) => Address.fromJson(json))
          .toList();
      final response1 = await http
          .get(Uri.parse("http://$server:8080/api/v1/province/get-all"));
      provinces = json
          .decode(response1.body)
          .cast<Map<String, dynamic>>()
          .map<Province>((json) => Province.fromJson(json))
          .toList();
      yield InitialAddressState();
    }

    if (event is GetDistrictEvent) {
      yield LoadAddress();
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/province/${event.provinceId}/get-districts"));
      districts = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<District>((json) => District.fromJson(json))
          .toList();
      yield InitialAddressState();
    }
    if (event is GetWardEvent) {
      yield LoadAddress();
      final response = await http.get(Uri.parse(
          "http://$server:8080/api/v1/province/district/${event.districtId}/get-wards"));
      wards = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<Ward>((json) => Ward.fromJson(json))
          .toList();
      yield InitialAddressState();
    }
    if (event is AddNewAddressEvent) {
      yield LoadAddress();
      final response = await http.post(
          Uri.http("$server:8080", "/api/v1/user/${event.userId}/add-address",
              {"ward": event.ward}),
          body: jsonEncode(<String, String>{
            "name": event.name,
            "numberPhone": event.numberPhone,
            "specificAddress": event.specificAddress,
            "defaultIs": event.defaultIs.toString()
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      yield AddSuccessAddress();
      yield InitialAddressState();
    }
    if (event is UpdateAddressEvent) {
      yield LoadAddress();

      print(jsonEncode({
        "id": event.addressId,
        "name": event.name,
        "numberPhone": event.numberPhone,
        "specificAddress": event.specificAddress,
        "defaultIs": event.defaultIs.toString(),
        "ward": {
          "id": event.ward
        }
      }));
      final response = await http.put(
          Uri.http(
            "$server:8080",
            "/api/v1/address/update",
          ),
          body: jsonEncode({
            "id": event.addressId,
            "name": event.name,
            "numberPhone": event.numberPhone,
            "specificAddress": event.specificAddress,
            "defaultIs": event.defaultIs.toString(),
            "ward": {
              "id": event.ward
            }
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      yield UpdateSuccessAddress();
      yield InitialAddressState();
    }
    if(event is ChooseUnitAddressEvent)
      {
        yield LoadAddress();
        switch(event.type){
          case "province":
          selectedProvice = event.index;
          break;
          case "district":
            selectedDistric = event.index;
            break;
          case "ward":
            selectedWard =event.index;
            break;
          default:
            break;
        }

        yield InitialAddressState();
      }
  }
}
