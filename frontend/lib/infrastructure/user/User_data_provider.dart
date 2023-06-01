// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:traditional_financial_asistant/domain/ekub/models/Notifications.dart';
import 'package:traditional_financial_asistant/domain/register/memeber_model.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/user.Dto.dart';

import '../../domain/register/User.dart';
import '../register/memberDto.dart';

class UserDataProvider {
  static const String _baseUrl = "http://192.168.251.221:3000/equb";

  Future<List<MemberDto>> fetchAllMembers(String name, accessToken) async {
    print('user provider');
    final response = await http.get(
      Uri.parse("$_baseUrl/members/:$name"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );
    print('member response');
    print(response.statusCode);
    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonList = json.decode(jsonString);
      List<MemberDto> MemberDtoList =
          jsonList.map((e) => MemberDto.fromJson(e)).toList();
      print(MemberDtoList);

      return MemberDtoList;
    } else {
      throw Exception("Could not update the Ekub");
    }
  }

  Future<Users> fetchWinner(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/currentwinner/:$id"));
    if (response.statusCode == 200) {
      final Users = jsonDecode(response.body);
      return Users;
    } else {
      throw Exception("Could not fetch Winner");
    }
  }

  Future<void> makePayment(String name,accessToken) async {
    print('gets to the provider');
    final response = await http.get(Uri.parse("$_baseUrl/pay/$name"),
    headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
    print(response.statusCode);
    if (response.statusCode == 201) {
    } else {
      throw Exception("Could not fetch Ekubs");
    }
  }

  Future<List<Notifications>> getNotification() async {
    final response = await http.get(Uri.parse("$_baseUrl/notification"));
    if (response.statusCode == 200) {
      final notifications = jsonDecode(response.body) as List;
      return notifications.map((e) => Notifications.fromJson(e)).toList();
    } else {
      throw Exception("Could not fetch Winner");
    }
  }

  Future<void> deleteNotification() async {
    final response =
        await http.delete(Uri.parse("$_baseUrl/deleteNotification"));
    if (response.statusCode == 200) {
    } else {
      throw Exception("Could not fetch Winner");
    }
  }

  Future<List<MemberDto>> blackList(String name, accessToken) async {
    print('blacklist provider');
    final response = await http.get(
      Uri.parse("$_baseUrl/blacklist/$name"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );
    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonList = json.decode(jsonString);
      List<MemberDto> MemberDtoList =
          jsonList.map((e) => MemberDto.fromJson(e)).toList();

      print(MemberDtoList);
      print('works fine');

      return MemberDtoList;
    } else {
      throw Exception("Could not fetch Winner");
    }
  }

  Future<void> deleteMember(String username, String equbId) async {
    final response =
        await http.delete(Uri.parse("$_baseUrl/deleteNotification"));
    if (response.statusCode == 200) {
    } else {
      throw Exception("Could not fetch Winner");
    }
  }
}
