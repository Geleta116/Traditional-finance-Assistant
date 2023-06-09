import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/accessToken.Dto.dart';
import '../../domain/auth/AuthFailure.dart';
import '../../domain/auth/User.dart';
import 'authentication_provider.dart';
import 'package:traditional_financial_asistant/domain/auth/authenticationRepositoryInterface.dart';
import 'package:traditional_financial_asistant/local_storage/local_storage.dart';

class AuthenticationRepository implements AuthenticationRepositroyInterface {
  AuthenticationProvider? authProvider;
  DbHelper? dbHelper;

  AuthenticationRepository(this.authProvider, {DbHelper? passedDB})
      : dbHelper = passedDB ?? DbHelper();
  @override
  Future<void> logIn(User user) async {
    try {
      print('auth repo');
      // accept the dto and convert it to an entity
      AccessTokenDto accessToken = await authProvider!.logIn(user);
      print("repo $accessToken");
      int personId = await dbHelper!.insertUser(accessToken.toJson());
      print('person with $personId successfully created');
      // save the entity to the local storage
    } catch (error) {
      ;
      throw Exception(error);
    }
  }

  @override
  void logOut() {}

  Future<Either<String, int>> loggedIn() async {
    try {
      await dbHelper!.getAccessToken();
      return Right(1);
    } catch (error) {
      return Left('access token not found');
    }
  }
}
