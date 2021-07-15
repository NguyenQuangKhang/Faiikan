import 'package:equatable/equatable.dart';

abstract class LoginSocialEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoggedInGoogle extends LoginSocialEvent {}

class LoggedInFacebook extends LoginSocialEvent {}

class LoggedInApple extends LoginSocialEvent {}
