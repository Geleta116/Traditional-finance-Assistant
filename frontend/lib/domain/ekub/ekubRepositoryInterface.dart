import 'package:traditional_financial_asistant/infrastructure/ekub/ekub_crate.Dto.dart';

import 'Ekub.dart';

abstract class EkubRepositoryInterface {
  Future<EkubCreateDto> create(Ekub ekub);
  Future<Ekub> update(int id, Ekub ekub);
  Future<List<Ekub>> fetchAllEnrolled();
  Future<Ekub> join(String name, String code);
  // Future<void> delete(int id);
  // Future<List<User>> fetchAllMembers(int id);
  // Future<User> fetchWinner(int id);
  // Future<void> makePayment(int id);
  // Future<List<Notifications>> getNotification();
}
