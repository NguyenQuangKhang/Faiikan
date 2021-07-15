import 'package:equatable/equatable.dart';

abstract class LoginSocialState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSocialInitial extends LoginSocialState {}

class LoginSocialLoading extends LoginSocialState {}



class LoginSocialCancelled extends LoginSocialState {
  LoginSocialCancelled({required this.textCancel});

  final String textCancel;
}

class LoginSocialSuccess extends LoginSocialState {}

class LoginSocialFailure extends LoginSocialState {
  LoginSocialFailure(this.error);

  final String error;
}
