import 'dart:async';

import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';

import '../../domain/ekub/models/Notifications.dart';
// import '../User_models/User.dart';
// import '../User_data_provider/User_data_provider.dart';
// import '../User_models/Notifications.dart';
import 'User_data_provider.dart';


class UserRepository{
  final UserDataProvider dataProvider;
  UserRepository(this.dataProvider);

  
  // Future<void> delete(int id) async {
  //   dataProvider.delete(id);
  // }

  Future<List<Users>> fetchAllMembers(int id) async {
    return dataProvider.fetchAllMembers(id);
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


}
