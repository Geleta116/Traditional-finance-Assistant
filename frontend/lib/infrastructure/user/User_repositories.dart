import 'dart:async';

import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';
import 'package:traditional_financial_asistant/infrastructure/register/memberDto.dart';

import '../../domain/ekub/models/Notifications.dart';
// import '../User_models/User.dart';
// import '../User_data_provider/User_data_provider.dart';
// import '../User_models/Notifications.dart';
import '../../domain/register/memeber_model.dart';
import '../../local_storage/local_storage.dart';
import 'User_data_provider.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  UserRepository(this.dataProvider);
  DbHelper helper = DbHelper();

  // Future<void> delete(int id) async {
  //   dataProvider.delete(id);
  // }

  Future<List<Member>> fetchAllMembers(String name) async {
    print('user rep');
    List<Member>? members;
    // check if the data is in local storage
    members = await helper.getAllMembers(name);
    String accessToken = await helper.getAccessToken();
    print('out of local storage');
    print(members);
    if (members != null && members.isNotEmpty) {
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
}
