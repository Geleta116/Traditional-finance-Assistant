import 'dart:async';
import 'package:traditional_financial_asistant/domain/ekub/Ekub.dart';
import 'package:traditional_financial_asistant/domain/join/join.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/Ekub_data_provider.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/ekub.Dto.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/ekub_crate.Dto.dart';
import 'package:traditional_financial_asistant/local_storage/local_storage.dart';
import 'package:traditional_financial_asistant/domain/ekub/ekubRepositoryInterface.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/Ekub.dart';

class EkubRepository implements EkubRepositoryInterface {
  final EkubDataProvider dataProvider;
  EkubRepository(this.dataProvider);
  DbHelper helper = DbHelper();
  @override
  Future<EkubCreateDto> create(Ekub ekub) async {
    print('ekub create repositroy');
    String accessToken = await helper.getAccessToken();

    EkubCreateDto ekubDto = await dataProvider.create(ekub.toDto(), accessToken);
    // await helper.insertEkub([createEkub.toEntity()]);

    return ekubDto;
  }

  @override
  Future<Ekub> update(int id, Ekub ekub) async {
    EkubDto updateEkub = await dataProvider.update(id, ekub.toDto());
    await helper.updateEkub(updateEkub.toEntity().toJson());
    return updateEkub.toEntity();
  }

  @override
  Future<List<Ekub>> fetchAllEnrolled() async {
    print("fetch all enrolld");
    // List<Ekub>? ekubListEntity = [];
    String accessToken = await helper.getAccessToken();
    print('accessToken');
    // //   List<Map<String, dynamic>> ekubList = await helper.getEkub();
    // ////////////////////////////////////////////////
    // List<Map<String, dynamic>>? ekubList = await helper.getEkub();

    // print(ekubList);
    // print('after cache');
    // if (ekubList == null) {
    //   print("calling remote");
    //   List<EkubDto> ekubDtoList =
    //       await dataProvider.fetchAllEnrolled(accessToken);
    //   ekubListEntity = ekubDtoList.map((e) => e.toEntity()).toList();
    //   await helper.insertEkub(ekubListEntity);
    // } else {
    //   ekubListEntity = ekubList.map((e) => Ekub.fromJson(e)).toList();
    // }

    // return ekubListEntity;
    
  print("fetch all enrolled");
  List<Ekub>? ekubListEntity;
  List<Map<String, dynamic>>? ekubList = await helper.getEkub();

  print(ekubList);
  print('after cache');

  try {
    List<EkubDto> ekubDtoList = await dataProvider.fetchAllEnrolled(accessToken);
    ekubListEntity = ekubDtoList.map((e) => e.toEntity()).toList();
    await helper.insertEkub(ekubListEntity);
    return ekubListEntity;
  } catch (error) {
    print("Error while calling remote API: $error");
    if (ekubList == null) {
      throw Exception("No cached data available");
    } else {
      ekubListEntity = ekubList.map((e) => Ekub.fromJson(e)).toList();
      return ekubListEntity;
    }
  }




    
  }

  @override
  Future<Ekub> join(String name, String code) async {
    EkubDto joinedEkub = await dataProvider.join(name, code);
    Ekub joinedEkubEntity = joinedEkub.toEntity();
    await helper.insertEkub([joinedEkubEntity]);
    return joinedEkubEntity;
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
