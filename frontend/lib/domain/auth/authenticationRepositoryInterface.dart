import 'package:dartz/dartz.dart';

import '../auth/User.dart';
abstract class AuthenticationRepositroyInterface {
  Future<void> logIn(User user);
  Future<Either<String, int>> loggedIn();
  void logOut();
}