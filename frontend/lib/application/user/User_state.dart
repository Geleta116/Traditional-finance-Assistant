import 'package:equatable/equatable.dart';
// import 'package:traditional_financial_asistant/domain/register/edirmember_model.dart';
import 'package:traditional_financial_asistant/domain/register/memeber_model.dart';
import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';
import 'package:bloc/bloc.dart';

import '../../domain/register/edirmember.dart';

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


class MemberOperationSuccess extends UserState {
  final List<Member> members;

  MemberOperationSuccess(this.members);

  @override
  List<Object?> get props => [members];
}

class EdirMemberOperationSuccess extends UserState {
  final List<EdirMember> members;

  EdirMemberOperationSuccess(this.members);

  @override
  List<Object?> get props => [members];
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
  List<Object?> get props => [];
}

class MakePayements extends UserState {
  final int money;

  const MakePayements(this.money);

  @override
  List<Object?> get props => [];
}

class BlackListMemberOperationSuccess extends UserState {
  final List<Member> members;

  const BlackListMemberOperationSuccess(this.members);

  @override
  List<Object?> get props => [members];
}

class PayOperationSuccess extends UserState {
  

  PayOperationSuccess();

  @override
  List<Object?> get props => [];
}
class ChangePasswordSuccess extends UserState {
  

  ChangePasswordSuccess();

  @override
  List<Object?> get props => [];
}
class ChangePasswordFaliure extends UserState {
  

  ChangePasswordFaliure();

  @override
  List<Object?> get props => [];
}


class depositeMoney extends UserState {
  final int money;

  const depositeMoney(this.money);

  @override
  List<Object?> get props => [];
}
class LogoutSuccesfull extends UserState {
  const LogoutSuccesfull();

  @override
  List<Object?> get props => [];
}
class LogoutUnsuccesfull extends UserState {
  const LogoutUnsuccesfull();

  @override
  List<Object?> get props => [];
}