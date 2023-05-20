import '../Ekub_data_provider/Ekub_data_provider.dart';
import '../Ekub_models/Ekub.dart';

class EkubRepository {
  final EkubDataProvider dataProvider;
  EkubRepository(this.dataProvider);

  Future<Ekub> create(Ekub ekub) async {
    return dataProvider.create(ekub);
  }

  Future<Ekub> update(int id, Ekub ekub) async {
    return dataProvider.update(id, ekub);
  }

  Future<List<Ekub>> fetchAll() async {
    return dataProvider.fetchAll();
  }

  Future<void> delete(int id) async {
    dataProvider.delete(id);
  }
}