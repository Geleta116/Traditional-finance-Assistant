// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traditional_financial_asistant/domain/auth/accessToken.dart';

import 'package:traditional_financial_asistant/domain/edir/models/models.dart';
import 'package:traditional_financial_asistant/domain/edir/models/models.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir.Dto.dart';

class EdirDataProvider {
  static const String _baseUrl = "http://localhost:3000/edir";

  Future<EdirDto> create(EdirDto edir, accessToken) async {
    print("edir provider");
    final http.Response response = await http.post(
        Uri.parse("$_baseUrl/create"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode(edir.toJson()));
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(response.body);
      return EdirDto.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create Edir");
    }
  }

  Future<List<EdirDto>> fetchAllEnrolled(accessToken) async {
    final response = await http.get(Uri.parse("$_baseUrl/all"),
        headers: <String, String>{"Authorization": "Bearer $accessToken"});
    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonList = json.decode(jsonString);
      List<EdirDto> equbDtoList =
          jsonList.map((e) => EdirDto.fromJson(e)).toList();
      return equbDtoList;
    } else {
      throw Exception("Could not fetch Edirs");
    }
  }

  Future<EdirDto> update(int id, EdirDto edir) async {
    final response = await http.put(Uri.parse("$_baseUrl/update/$id"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "name": edir.name,
          "amount": edir.amount,
          "duration": edir.duration
        }));

    if (response.statusCode == 200) {
      return EdirDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Edir");
    }
  }

  Future<EdirDto> join(String name, String code) async {
    final response = await http.post(Uri.parse("$_baseUrl/join"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "code": code,
        }));

    if (response.statusCode == 200) {
      return EdirDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Edir");
    }
  }

  // Future<List<User>> fetchAllMembers(int id) async {
  //   final response = await http.get(
  //     Uri.parse("$_baseUrl/members/:$id"),
  //     headers: <String, String>{"Content-Type": "application/json"},
  //   );

  //   if (response.statusCode == 200) {
  //     final Users = jsonDecode(response.body) as List;
  //     return Users.map((e) => User.fromJson(e)).toList();
  //   } else {
  //     throw Exception("Could not update the Edir");
  //   }
  // }

  // Future<User> fetchWinner(int id) async {
  //   final response = await http.get(Uri.parse("$_baseUrl/currentwinner/:$id"));
  //   if (response.statusCode == 200) {
  //     final Users = jsonDecode(response.body);
  //     return Users;
  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }

  // Future<void> makePayment(int id) async {
  //   final response = await http.get(Uri.parse("$_baseUrl/pay/:$id"));
  //   if (response.statusCode == 201) {
  //   } else {
  //     throw Exception("Could not fetch Edirs");
  //   }
  // }

  // Future<List> getNotification() async {
  //   final response = await http.get(Uri.parse("$_baseUrl/notification"));
  //   if (response.statusCode == 200) {
  //     final notifications = jsonDecode(response.body) as List;
  //     return notifications.map((e) => Notifications.fromJson(e)).toList();
  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }

  // Future<void> deleteNotification() async {
  //   final response = await http.delete(Uri.parse("$_baseUrl/deleteNotification"));
  //   if (response.statusCode == 200) {

  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }

  // Future<List<User>> blackList(int id) async {
  //   final response = await http.get(Uri.parse("$_baseUrl/blacklist/$id"));
  //   if (response.statusCode == 200) {
  //      final Users = jsonDecode(response.body) as List;
  //     return Users.map((e) => User.fromJson(e)).toList();
  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }

  // Future<void> deleteMember(String username, String equbId) async {
  //   final response = await http.delete(Uri.parse("$_baseUrl/deleteNotification"));
  //   if (response.statusCode == 200) {

  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }

  //  Future<List<Edir>> fetchAllEnrolled(String username, String equbId) async {
  //   final response = await http.get(Uri.parse("$_baseUrl/all"));
  //   if (response.statusCode == 200) {

  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }
}
