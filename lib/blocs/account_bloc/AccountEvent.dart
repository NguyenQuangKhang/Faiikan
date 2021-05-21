import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class LoginButtonPressed extends AccountEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
