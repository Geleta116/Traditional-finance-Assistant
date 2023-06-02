import 'dart:io';
import 'dart:convert';
import 'package:traditional_financial_asistant/domain/auth/accessToken.dart';

import '../../domain/auth/User.dart';
import "../../infrastructure/auth/accessToken.Dto.dart";
import 'package:http/http.dart' as http;

class AuthenticationProvider {

  String _baseUrl = 'http://192.168.43.47:3000/auth/login';


  Future<AccessTokenDto> logIn(User user) async {
    try {
      
      print(user.toDto().toJson());
      final http.Response response = await http.post(Uri.parse(_baseUrl),
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(user.toDto().toJson()));
      print(response.body);
      if (response.statusCode == 201) {

        AccessTokenDto accessToken = AccessTokenDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);

        return accessToken;
      } else {
        
        throw Exception("Failed to authenticate");
      }
    } catch (error) {
      print(error);
      
      throw Exception("Failed to authenticate");
    }
  }
}
