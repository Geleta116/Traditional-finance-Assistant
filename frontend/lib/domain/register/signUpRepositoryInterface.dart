
import 'package:traditional_financial_asistant/domain/register/User.dart';

abstract class SignUpRepositoryInterface {
  Future<Users> signUp(Users user);
}