import 'package:traditional_financial_asistant/domain/auth/User.dart';
import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';

import '../../infrastructure/register/signup_provider.dart';
import '../../domain/register/User.dart';
import 'package:traditional_financial_asistant/domain/register/signUpRepositoryInterface.dart';
import 'package:traditional_financial_asistant/local_storage/local_storage.dart';

class SignUpRepository implements SignUpRepositoryInterface {
  final SignUpDataProvider dataProvider;
  SignUpRepository(this.dataProvider);
  DbHelper localDatabase = DbHelper();
  @override
  Future<Users> signUp(Users user) async {
    try {
      // await localDatabase.dropDatabase();
      UserDto currUser = await dataProvider.create(user.toDto());
      return currUser.toEntity();
    } catch (error) {
      print(error);
      throw Exception("Failed to create user");
    }
  }
}
