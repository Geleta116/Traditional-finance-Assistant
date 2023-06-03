import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:traditional_financial_asistant/infrastructure/join/join.Dto.dart';

import '../ekub/ekub.Dto.dart';

class JoinDataProvider {
  static const String _baseUrl = "http://192.168.78.126:3000/equb";

  Future<EkubDto> joined(JoinDto join, accessToken) async {
    print("reached join provider");
    final response = await http.post(Uri.parse("$_baseUrl/join"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode({
          "name": join.name,
          "code": join.code,
        }));
    print(response.statusCode);
    if (response.statusCode == 201) {
      EkubDto dto = EkubDto.fromJson(jsonDecode(response.body));
      print(dto);
      return dto;
    } else {
      throw Exception("Could not update the Ekub");
    }
  }
}
