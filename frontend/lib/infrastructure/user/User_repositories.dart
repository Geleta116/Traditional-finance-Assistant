import 'dart:async';

import 'package:traditional_financial_asistant/domain/auth/auth_domain_barell.dart';
import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';
import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';
import 'package:traditional_financial_asistant/local_storage/local_storage.dart';

import '../../domain/ekub/models/Notifications.dart';
// import '../User_models/User.dart';
// import '../User_data_provider/User_data_provider.dart';
// import '../User_models/Notifications.dart';
import 'User_data_provider.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  DbHelper helper = DbHelper();
  UserRepository(this.dataProvider);

  // Future<void> delete(int id) async {
  //   dataProvider.delete(id);
  // }

  Future<List<Users>> fetchAllMembers(int id) async {
    return dataProvider.fetchAllMembers(id);
  }

  Future<Users> fetchMember() async {
    try {
      String accessToken = await helper.getAccessToken();
      print("jsdknj");
      UserDto users = await dataProvider.fetchMember(accessToken);
      print(users);
      return users.toEntity();
    } catch (e) {
      print("error in user repo");
      throw (e);
    }
  }

  Future<Users> fetchWinner(int id) async {
    return dataProvider.fetchWinner(id);
  }

  Future<void> makePayment(int id) async {
    return dataProvider.makePayment(id);
  }

  Future<List<Notifications>> getNotification() async {
    return dataProvider.getNotification();
  }

  Future<void> deleteNotification() async {
    return dataProvider.deleteNotification();
  }

  Future<List<Users>> blackList(int id) async {
    return dataProvider.blackList(id);
  }

  Future<void> deleteMember(String username, String equbId) {
    return dataProvider.deleteMember(username, equbId);
  }

  Future<Users> deposit(int money) async {
    try {
      String accessToken = await helper.getAccessToken();
      print(accessToken);
      UserDto users = await dataProvider.deposit(money, accessToken);
      print(users);
      return users.toEntity();
    } catch (e) {
      print("error in user repo");
      throw (e);
    }
  }
}
