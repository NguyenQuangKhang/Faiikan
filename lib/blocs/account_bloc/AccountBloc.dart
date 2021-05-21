import 'dart:async';
import 'dart:convert';

import 'package:faiikan/models/user.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'AccountEvent.dart';
import 'AccountState.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  late User user;

  AccountBloc(AccountState initialState) : super(initialState);

  @override
  AccountState get initialState => AccountInitial();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield AccountLoading();
      try {
        final response = await http.post(
          Uri.parse("http://$server:8080/api/v1/account/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": event.username,
            "password": event.password,
          }),
        );

        if (response.statusCode == 200) {
          user = User.fromJson(json.decode(response.body)["user"]);
          print(" userid: " + user.id.toString());
          yield AccountOk();
        } else {
          yield AccountInitial();

          yield AccountFailure(error: "login failed");
        }
      } catch (error) {
        yield AccountInitial();
        yield AccountFailure(error: error.toString());
      }
    }
  }
}
