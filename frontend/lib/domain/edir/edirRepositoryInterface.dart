import 'package:traditional_financial_asistant/infrastructure/edir/edir_create.Dto.dart';

import 'Edir.dart';

abstract class EdirRepositoryInterface {
  Future<CreateEdirDto> create(Edir edir);
  Future<Edir> update(int id, Edir edir);
  Future<List<Edir>> fetchAllEnrolled();
  Future<bool> deleteEdir(String name);
  Future<Edir> join(String name, String code);
  // Future<void> delete(int id);
  // Future<List<User>> fetchAllMembers(int id);
  // Future<User> fetchWinner(int id);
  // Future<void> makePayment(int id);
  // Future<List<Notifications>> getNotification();
}
