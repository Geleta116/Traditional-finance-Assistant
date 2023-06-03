import 'dart:async';
import 'dart:math';

import 'package:traditional_financial_asistant/domain/auth/accessToken.dart';
import 'package:traditional_financial_asistant/domain/join/join.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir_create.Dto.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir_data_provider.dart';

import '../../domain/edir/Edir.dart';
// import '../domain/edir/Edir.dart';
// import '../domain/edir/edirRepositoryInterface.dart';
// import '../local_storage/local_storage.dart';
import '../../domain/edir/edirRepositoryInterface.dart';
import '../../local_storage/local_storage.dart';
import 'edir.Dto.dart';

class EdirRepository implements EdirRepositoryInterface {
  final EdirDataProvider dataProvider;
  EdirRepository(this.dataProvider);
  DbHelper helper = DbHelper();

  Future<CreateEdirDto> create(Edir edir) async {
    print("edir repo");
    String accessToken = await helper.getAccessToken();
    CreateEdirDto edirDto =
        await dataProvider.create(edir.toDto(), accessToken);
    print(accessToken);
    return edirDto;
    try {
      // await helper.insertEdir([createEdir.toEntity()]);

      return edirDto;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<Edir> update(int id, Edir edir) async {
    String accessToken = await helper.getAccessToken();
    EdirDto updateEdir = await dataProvider.update(id, edir as EdirDto);
    // await helper.updateEdir(updateEdir.toEntity().toJson());
    return updateEdir.toEntity();
  }

  Future<List<Edir>> fetchAllEnrolled() async {
    List<Edir>? edirListEntity = [];
    print("edir repo reached");
    String accessToken = await helper.getAccessToken();
    print(accessToken);
    // List<Map<String, dynamic>> edirList = await helper.getEdir();
    // edirListEntity = edirList.map((e) => Edir.fromJson(e)).toList();
    // print(accessToken);
    if (edirListEntity.isEmpty) {
      List<EdirDto> edirList = await dataProvider.fetchAllEnrolled(accessToken);
      // print(edirList.length);
      // for (int i = 0; i < edirList.length; i++) {
      //   print(edirList[i].name);
      // }
      List<Edir> edirListEntity = edirList.map((e) => e.toEntity()).toList();
      // print(edirListEntity);
      // await helper.insertEdir(edirListEntity);
      print(edirListEntity);
      return edirListEntity;
    } else {
      return edirListEntity;
    }
    //we need to persist this data to local storage
  }

  Future<bool> deleteEdir(String name) async {
    String accessToken = await helper.getAccessToken();
    try {
      bool edir = await dataProvider.deleteEdir(name, accessToken);
      return edir;
    } catch (e) {
      throw (e);
    }
  }

  Future<Edir> join(String name, String code) async {
    EdirDto joinedEdir = await dataProvider.join(name, code);
    Edir joinedEdirEntity = joinedEdir.toEntity();
    await helper.insertEdir([joinedEdirEntity]);
    return joinedEdirEntity;
  }

  static joined(Join edir) {}

  // Future<void> delete(int id) async {
  //   dataProvider.delete(id);
  // }

  // Future<List<User>> fetchAllMembers(int id) async {
  //   return dataProvider.fetchAllMembers(id);
  // }

  // Future<User> fetchWinner(int id) async {
  //   return dataProvider.fetchWinner(id);
  // }

  // Future<void> makePayment(int id) async {
  //   return dataProvider.makePayment(id);
  // }

  // Future<List<Notifications>> getNotification() async {
  //   return dataProvider.getNotification();
  // }

  // Future<void> deleteNotification() async {
  //   return dataProvider.deleteNotification();
  // }

  // Future<List<User>> blackList(int id) async {
  //   return dataProvider.blackList(id);
  // }

  // Future<void> deleteMember(String username, String equbId) {
  //   return dataProvider.deleteMember(username, equbId);
  // }
}
