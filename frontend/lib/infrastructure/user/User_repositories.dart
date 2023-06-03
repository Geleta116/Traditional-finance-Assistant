import 'dart:async';

import 'package:traditional_financial_asistant/domain/auth/auth_domain_barell.dart';
import 'package:traditional_financial_asistant/domain/auth/change_password.dart';
import 'package:traditional_financial_asistant/domain/notification/Notification.dart';
// import 'package:traditional_financial_asistant/domain/register/edirmember_model.dart';
import 'package:traditional_financial_asistant/domain/register/memeber_model.dart';
import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';
import 'package:traditional_financial_asistant/infrastructure/register/edirmember.Dto.dart';
import 'package:traditional_financial_asistant/infrastructure/register/memberDto.dart';
import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';
import 'package:traditional_financial_asistant/local_storage/local_storage.dart';

// import '../domain/ekub/models/Notifications.dart';
// import '../User_models/User.dart';
// import '../User_data_provider/User_data_provider.dart';
// import '../User_models/Notifications.dart';
import '../../domain/register/edirmember.dart';
import 'User_data_provider.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  DbHelper helper = DbHelper();
  UserRepository(this.dataProvider);

  // Future<void> delete(int id) async {
  //   dataProvider.delete(id);
  // }

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

  Future<List<Member>> fetchAllMembers(String name) async {
    print('user rep');
    List<Member>? members;
    // check if the data is in local storage
    // members = await helper.getAllMembers(name);
    print(members);
    String accessToken = await helper.getAccessToken();
    print('out of local storage');
    print(members);
    if (members != null && members.isNotEmpty) {
      print("what");
      return members;
    } else {
      print('goes to else');
      List<MemberDto> membersListDto =
          await dataProvider.fetchAllMembers(name, accessToken);
      // persist the data in local storage
      print('out of provide');
      print(membersListDto);

      members = membersListDto.map((e) => e.toMemeber()).toList();
      print('still works');
      print(members);
      await helper.insertMember(members, name);
      return members;
    }

    // persist the data in local storage
  }

  Future<List<EdirMember>> fetchAllEdirMembers(String name) async {
    print('user rep');
    List<EdirMember>? members;
    // check if the data is in local storage

    members = await helper.getAllEdirMembers(name);

    String accessToken = await helper.getAccessToken();
    print('out of local storage');
    print(members);
    if (members != null && members.isNotEmpty) {
      return members;
    } else {
      try {
        print('goes to else');
        List<EdirMemberDto> membersListDto =
            await dataProvider.fetchAllEdirMembers(name, accessToken);
        // persist the data in local storage
        print('out of provide');
        print(membersListDto);

        members = membersListDto.map((e) => e.toEdirMemeber()).toList();
        print('still works');
        print(members);
        await helper.insertEdirMember(members, name);
        print("it passed");
        return members;
      } catch (e) {
        print(e);
        throw(e);
      }
    }

    // persist the data in local storage
  }

  // Future<Users> fetchWinner(int id) async {
  //   return dataProvider.fetchWinner(id);
  // }

 Future<void> makePayment(String name) async {
    print('payment repo');
    String accessToken = await helper.getAccessToken();
    return dataProvider.makePayment(name, accessToken);
  }

  Future<void> makeEdirPayment(String name) async {
    print('payment repo');
    String accessToken = await helper.getAccessToken();
    return dataProvider.makeEdirPayment(name, accessToken);
  }
  Future<List<Notifications>> getNotification() async {
    return dataProvider.getNotification();
  }

  Future<void> deleteNotification() async {
    return dataProvider.deleteNotification();
  }

  Future<List<Member>> blackList(String name) async {
    print('blacklist repo');
    String accessToken = await helper.getAccessToken();
    List<MemberDto> membersListDto =
        await dataProvider.blackList(name, accessToken);
    List<Member> members = membersListDto.map((e) => e.toMemeber()).toList();
    return members;
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

  Future<Users> changePassword(ChangePasswordModel changePassword) async {
    print('change pass repo');
    try {
      
      String accessToken = await helper.getAccessToken();
      print(accessToken);
      UserDto users =
          await dataProvider.changePassword(accessToken, changePassword);
      print(users);
      return users.toEntity();
    } catch (e) {
      print("error in user repo");
      throw (e);
    }
  }
  logout() async {
    print('logout rep');

    await helper.dropDatabase();
  }
}
