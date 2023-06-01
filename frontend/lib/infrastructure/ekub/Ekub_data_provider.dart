// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traditional_financial_asistant/domain/auth/accessToken.dart';

import 'package:traditional_financial_asistant/domain/ekub/models/models.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/models.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/ekub.Dto.dart';

class EkubDataProvider {
  static const String _baseUrl = "http://10.4.101.40:3000/equb";

  Future<EkubDto> create(EkubDto ekub, accessToken) async {
    try {
      print('ekub provider');

      final http.Response response = await http.post(
          Uri.parse("$_baseUrl/create/"),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          },
          body: jsonEncode(ekub.toJson()));

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        return EkubDto.fromJson(jsonDecode(response.body));
      }
      {
        throw Exception("Failed to create Ekub");
      }
    } catch (e) {
      print("hasn't reached ekub provider");
      print(e);
      return ekub;
    }
  }

  Future<List<EkubDto>> fetchAllEnrolled(accessToken) async {
    print("all enrolled prov ${accessToken}");
    try {
      final response = await http.get(Uri.parse("$_baseUrl/all"),
          headers: <String, String>{"Authorization": "Bearer $accessToken"});

      if (response.statusCode == 200) {
        print("FETCHED");
        var ekubs = jsonDecode(response.body);

        print(response.body);
        // List<EkubDto> ekubsList = EkubDto.fromJson(jsonDRecode(response.body));

        //      List<EkubDto> ekubsList = ekubs
        // .map((e) => e != null ? EkubDto.fromJson(jsonDecode(jsonEncode(e))) : null)
        // .toList();
        String jsonString = response.body;
        List<dynamic> jsonList = json.decode(jsonString);
        List<EkubDto> equbDtoList = jsonList.map((e) => EkubDto.fromJson(e)).toList();
        print('after response');

        return equbDtoList;
      } else {
        print("provider error");
        throw Exception("Could not fetch Ekubs");
      }
    } catch (e) {
      print(e);
      throw Exception("Could not fetch Ekubs");
    }
  }

  Future<EkubDto> update(int id, EkubDto ekub) async {
    final response = await http.put(Uri.parse("$_baseUrl/update/$id"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "name": ekub.name,
          "amount": ekub.amount,
          "num_people": ekub.minMembers,
          "duration": ekub.duration
        }));

    if (response.statusCode == 200) {
      return EkubDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Ekub");
    }
  }

  Future<EkubDto> join(String name, String code) async {
    final response = await http.post(Uri.parse("$_baseUrl/join"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "code": code,
        }));

    if (response.statusCode == 200) {
      return EkubDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Ekub");
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
  //     throw Exception("Could not update the Ekub");
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
  //     throw Exception("Could not fetch Ekubs");
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

  //  Future<List<Ekub>> fetchAllEnrolled(String username, String equbId) async {
  //   final response = await http.get(Uri.parse("$_baseUrl/all"));
  //   if (response.statusCode == 200) {

  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }
}
