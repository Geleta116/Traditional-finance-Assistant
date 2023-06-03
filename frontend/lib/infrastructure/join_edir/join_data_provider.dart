import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:traditional_financial_asistant/infrastructure/join/join.Dto.dart';

import '../edir/edir.Dto.dart';

class JoinEdirDataProvider {
  static const String _baseUrl = "http://10.4.101.40:3000/edir";

  Future<EdirDto> joined(JoinDto join, accessToken) async {
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

    if (response.statusCode == 201) {
      EdirDto dto = EdirDto.fromJson(jsonDecode(response.body)["edir"]);
      print(dto);
      return dto;
    } else {
      throw Exception("Could not update the Edir");
    }
  }
}
