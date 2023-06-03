import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import '../../infrastructure/auth/user.Dto.dart';
import 'AuthFailure.dart';
import 'Password.dart';
import 'username.dart';

class User {
  final Username username;
  final Password password;

  User({
    required this.username,
    required this.password,
  });

  factory User.create({
    required Username username,
    required Password password,
  }) {
    return User(
      username: username,
      password: password,
    );
  }

  Either<AuthFailure, Unit> validateCredentials() {
    if (username.value.isLeft()) {
      return left(const InvalidUsername());
    } else if (password.value.isLeft()) {
      return left(const InvalidPassword());
    } else {
      return right(unit);
    }
  }

  UserDto toDto() {
    return UserDto(
      username: username.value.getOrElse(() => ''),
      password: password.value.getOrElse(() => ''),
    );
  }
}
