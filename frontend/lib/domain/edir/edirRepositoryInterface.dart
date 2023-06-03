import 'Edir.dart';

abstract class EdirRepositoryInterface {
  Future<bool> create(Edir edir);
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
