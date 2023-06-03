import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:traditional_financial_asistant/domain/register/blance.dart';

import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';

import 'AuthFailure.dart';
import 'Password.dart';
import 'Username.dart';
import 'fullname.dart';
import 'email.dart';



class Users {
  final Username username;
  final Password password;
  final FullName fullName;
  final Balance balance;
  final Email email;

  Users({
    required this.username,
    required this.password,
    required this.fullName,
    required this.email,
    required this.balance,
  });

  factory Users.create({
    required Username username,
    required Password password,
    required FullName fullName,
    required Email email,
    required Balance balance,
  }) {
    return Users(
      username: username,
      password: password,
      fullName: fullName,
      email: email,
      balance: balance
    );
  }

  Either<AuthFailure, Unit> validateCredentials() {
    if (username.value.isLeft()) {
      return left(const InvalidUsername());
    } else if (password.value.isLeft()) {
      return left(const InvalidPassword());
    } else if (email.value.isLeft()) {
      return left(const InvalidPassword());
    } else if (balance.value.isLeft()) {
      return left(const InvalidPassword());
    } else if (fullName.value.isLeft()) {
      return left(const InvalidPassword());
    }else {
      return right(unit);
    }
  }

UserDto toDto() {
    return UserDto(
      username: username.value.getOrElse(() => ''),
      password: password.value.getOrElse(() => ''),
      fullName: fullName.value.getOrElse(() => ''),
      email: email.value.getOrElse(() => ''),
     balance: int.parse(balance.value.getOrElse(() => '0')),
    );
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(

        username: json['username'],
        password: json['password'],
        email: json['email'],
        fullName: json['fullName'],
        balance: json['balance']);
  }

}
