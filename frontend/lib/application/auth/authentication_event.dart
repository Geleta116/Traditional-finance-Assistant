part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  User user;

  LoginEvent(this.user);
}

class LogoutEvent extends AuthenticationEvent {}
