import 'package:traditional_finance_assistant__app/domain/auth/User.dart';
import 'package:traditional_finance_assistant__app/domain/auth/username.dart';
import 'package:traditional_finance_assistant__app/domain/auth/Password.dart';

class UserDto {
  
  String? username;
  String? password;

  UserDto({this.username, this.password});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        username: json['username'],
        password: json['password'],
      );

  User toEntity() {
    return User(
      username: Username(username!),
      password: Password(password!)
    );
  }
}
