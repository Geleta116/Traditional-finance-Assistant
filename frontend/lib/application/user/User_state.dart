import 'package:equatable/equatable.dart';
import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';
import 'package:bloc/bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UsersLoad extends UserState {}

class UserLoadedState extends UserState {
  final List<Users> users;

  UserLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UserOperationSuccess extends UserState {
  final List<Users> users;

  UserOperationSuccess(this.users);

  @override
  List<Object?> get props => [users];
}

class UserOperationFailure extends UserState {
  final String error;

  UserOperationFailure(this.error);
}

class UsersData extends UserState {
  final Users users;

  const UsersData(this.users);

  @override
  List<Object?> get props => [users];
}
