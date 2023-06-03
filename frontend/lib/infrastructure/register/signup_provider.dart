// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';

import '../../domain/register/User.dart';

class SignUpDataProvider {
  static const String _baseUrl = "http://192.168.78.126:3000/user/signup";

  Future<UserDto> create(UserDto user) async {
    try {
      print('gets to the provider');

      final http.Response response = await http.post(Uri.parse(_baseUrl),
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(user.toJson()));
      print(response.statusCode);
      if (response.statusCode == 201) {
        return UserDto.fromJson(jsonDecode(response.body));
      }
      {
        print("wrong");
        throw Exception("Failed to create user");
      }
    } catch (error) {
      print(error);
      throw Exception("yoooo");
    }
  }
}
