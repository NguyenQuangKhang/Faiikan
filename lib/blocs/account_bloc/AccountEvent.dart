import 'dart:io';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}
class InitialAccount extends AccountEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class LogOutEvent extends AccountEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class RegisterEvent extends AccountEvent {
  final String username;
  final String password;
  final String name;

  RegisterEvent({required this.username,required this.password,required this.name});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
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
class UpdateProfileInfo extends AccountEvent {
  final String id;
  final String name;
  final String phone;
  final String sex;
  final File? avarta;
  final String? birthday;
  final String email;

  const UpdateProfileInfo({
    required this.id,
    required this.name,
    required this.sex,
    required this.avarta,
    required this.phone,
    required this.birthday,
    required this.email,
  });

  @override
  List<Object> get props => [];


}
