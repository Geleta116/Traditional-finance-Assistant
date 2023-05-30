
import 'package:traditional_finance_assistant__app/domain/register/User.dart';

abstract class SignUpRepositoryInterface {
  Future<Users> signUp(Users user);
}