import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountFailure extends AccountState {
  final String error;

  const AccountFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}


class AccountOk extends AccountState {}
