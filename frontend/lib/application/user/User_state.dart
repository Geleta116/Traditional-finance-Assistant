import 'package:equatable/equatable.dart';
import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';
import 'package:bloc/bloc.dart';

import '../../domain/register/memeber_model.dart';

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
class MemberOperationSuccess extends UserState {
  final List<Member> members;

  MemberOperationSuccess(this.members);

  @override
  List<Object?> get props => [members];
}
class PayOperationSuccess extends UserState {
  

  PayOperationSuccess();

  @override
  List<Object?> get props => [];
}

class UserOperationFailure extends UserState {
  final String error;

  UserOperationFailure(this.error);
}

class UsersData extends UserState {
  final Users users;

  const UsersData(this.users);

  @override
  List<Object?> get props => [];
}
class BlackListMemberOperationSuccess extends UserState {
  final List<Member> members;

  const BlackListMemberOperationSuccess(this.members);

  @override
  List<Object?> get props => [members];
}
// class fetchAllMembers extends UserState {
//   final String name;

//   const fetchAllMembers(this.name);

//   @override
//   List<Object?> get props => [name];
// }

class MakePayements extends UserState {
  final int money;

  const MakePayements(this.money);

  @override
  List<Object?> get props => [];
}
