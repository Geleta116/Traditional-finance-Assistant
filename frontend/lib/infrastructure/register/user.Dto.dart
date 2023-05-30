import 'package:traditional_financial_asistant/domain/register/Password.dart';
import 'package:traditional_financial_asistant/domain/register/Username.dart';
import 'package:traditional_financial_asistant/domain/register/blance.dart';
import 'package:traditional_financial_asistant/domain/register/email.dart';
import 'package:traditional_financial_asistant/domain/register/fullname.dart';

import '../../domain/register/User.dart';

class UserDto {
  String? username;
  String? password;
  String? fullName;
  String? email;
  int? balance;

  UserDto(
      {this.username, this.password, this.fullName, this.email, this.balance});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        "fullName": fullName,
        "email": email,
        "balance": balance
      };

  factory UserDto.fromJson(Map<String, dynamic> json) {
    UserDto temp = UserDto(
        username: json['username'],
        password: json['password'],
        balance: json['balance'],
        email: json['email'],
        fullName: json['fullName']);
   
    return temp;
  }

  Users toEntity() {
    return Users(
        username: Username(username!),
        password: Password(password!),
        email: Email(email!),
        balance: Balance(balance!.toString()),
        fullName: FullName(fullName!));
  }
}
