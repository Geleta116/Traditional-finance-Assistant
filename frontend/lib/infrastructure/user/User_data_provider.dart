// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:traditional_financial_asistant/domain/auth/change_password.dart';
// import 'package:traditional_financial_asistant/domain/ekub/models/Notifications.dart';
import 'package:traditional_financial_asistant/domain/register/User.dart';
import 'package:traditional_financial_asistant/infrastructure/register/edirmember.Dto.dart';
import 'package:traditional_financial_asistant/infrastructure/register/memberDto.dart';
import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';

import '../../domain/notification/Notification.dart';

// import '../domain/register/User.dart';

class UserDataProvider {
  static const String _baseUrl = "http://10.4.101.40:3000";

  Future<List<MemberDto>> fetchAllMembers(String name, accessToken) async {
    print('user provider');
    final response = await http.get(
      Uri.parse("$_baseUrl/equb/members/:$name"),
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

  Future<List<EdirMemberDto>> fetchAllEdirMembers(
      String name, accessToken) async {
    print("name");
    final response = await http.get(
      Uri.parse("$_baseUrl/edir/members/$name"),
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
      List<EdirMemberDto> MemberDtoList =
          jsonList.map((e) => EdirMemberDto.fromJson(e)).toList();
      print(MemberDtoList);

      return MemberDtoList;
    } else {
      throw Exception("Could not update the Edir");
    }
  }

  Future<UserDto> fetchMember(String accessToken) async {

    try
  {  final response = await http.get(
      Uri.parse("$_baseUrl/user/info/"),
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
    }}

    catch (e){
      print(e);
      throw Exception("Could not find the user");

    }
  }

  // Future<Users> fetchWinner(int id) async {
  //   final response = await http.get(Uri.parse("$_baseUrl/currentwinner/:$id"));
  //   if (response.statusCode == 200) {
  //     final Users = jsonDecode(response.body);
  //     return Users;
  //   } else {
  //     throw Exception("Could not fetch Winner");
  //   }
  // }

  Future<List<Notifications>> getNotification() async {
    final response = await http.get(Uri.parse("$_baseUrl/equb/notification"));
    if (response.statusCode == 200) {
      final notifications = jsonDecode(response.body) as List;
      return notifications.map((e) => Notifications.fromJson(e)).toList();
    } else {
      throw Exception("Could not fetch Winner");
    }
  }

  Future<void> deleteNotification() async {
    final response =
        await http.delete(Uri.parse("$_baseUrl/equb/deleteNotification"));
    if (response.statusCode == 200) {
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
    final response = await http.post(Uri.parse("$_baseUrl/user/deposit"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer: $accessToken"
        },
        body: jsonEncode({
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

  Future<void> makePayment(String name, accessToken) async {
    print('gets to the provider');
    final response = await http.get(Uri.parse("$_baseUrl/equb/pay/$name"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    // print(response.statusCode);
    if (response.statusCode == 201) {
    } else {
      throw Exception("Could not fetch Ekubs");
    }
  }

  Future<void> makeEdirPayment(String name, accessToken) async {
    print('gets to the provider edir');

    final response = await http.post(Uri.parse("$_baseUrl/edir/pay/$name"),
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

  Future<List<MemberDto>> blackList(String name, accessToken) async {
    print('blacklist provider');
    final response = await http.get(
      Uri.parse("$_baseUrl/blacklist/$name"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );
    print(response.statusCode);
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

  Future<UserDto> changePassword(
      String accessToken, ChangePasswordModel changePassword) async {
    print('change pass provider');
    try {
      final response = await http.patch(
          Uri.parse("$_baseUrl/user/changepassoword"),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer: $accessToken"
          },
          body: jsonEncode(changePassword.toJson()));
      print(response.statusCode);
      if (response.statusCode == 200) {
        UserDto d = UserDto.fromJson(jsonDecode(response.body));

        return d;
      } else {
        throw Exception("Could not change password");
      }
    } catch (e) {
      print(e);
      throw Exception("Could not change password");
    }
  }
}
