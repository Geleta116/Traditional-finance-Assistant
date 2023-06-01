import 'Edir.dart';

abstract class EdirRepositoryInterface {
  Future<Edir> create(Edir edir);
  Future<Edir> update(int id, Edir edir);
  Future<List<Edir>> fetchAllEnrolled();
  Future<Edir> join(String name, String code);
  // Future<void> delete(int id);
  // Future<List<User>> fetchAllMembers(int id);
  // Future<User> fetchWinner(int id);
  // Future<void> makePayment(int id);
  // Future<List<Notifications>> getNotification();
}