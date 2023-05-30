// auth_failure.dart

import 'package:equatable/equatable.dart';

abstract class AuthFailure extends Equatable {
  const AuthFailure();

  @override
  List<Object> get props => [];
}

class InvalidCredentials extends AuthFailure {
  const InvalidCredentials();
}

class InvalidUsername extends AuthFailure {
  const InvalidUsername();
}

class UsernameTooShort extends AuthFailure {
  const UsernameTooShort();
}

class InvalidUsernameFormat extends AuthFailure {
  const InvalidUsernameFormat();
}

class InvalidPassword extends AuthFailure {
  const InvalidPassword();
}
