// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:traditional_financial_asistant/domain/ekub/models/Notifications.dart';
import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';

import '../../domain/register/User.dart';

class UserDataProvider {
  static const String _baseUrl = "http://localhost:3000/user";

  Future<List<Users>> fetchAllMembers(int id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/members/:$id"),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final users = jsonDecode(response.body) as List;
      return users.map((e) => Users.fromJson(e)).toList();
    } else {
      throw Exception("Could not update the Ekub");
    }
  }

  Future<UserDto> fetchMember(String accessToken) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/info/"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      UserDto d = UserDto.fromJson(jsonDecode(response.body));

      return d;
    } else {
      throw Exception("Could not find the user");
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

  Future<void> makePayment(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/pay/:$id"));
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

  Future<List<Users>> blackList(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/blacklist/$id"));
    if (response.statusCode == 200) {
      final users = jsonDecode(response.body) as List;
      return users.map((e) => Users.fromJson(e)).toList();
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

  Future<UserDto> deposit(int money, String accessToken) async {
    final response = await http.post(Uri.parse("$_baseUrl/deposit"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer: $accessToken"
        },body: jsonEncode({
          "amount": money,
        }));
    print(response.statusCode);
    if (response.statusCode == 201) {
      
       UserDto d = UserDto.fromJson(jsonDecode(response.body));

      return d;
    } else {
      throw Exception("Could not deposit money");
    }
  }
}
