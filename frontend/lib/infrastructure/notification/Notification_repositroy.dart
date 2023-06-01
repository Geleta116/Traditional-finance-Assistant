import 'package:traditional_financial_asistant/local_storage/local_storage.dart';

import '../../domain/notification/Notification.dart';
import 'Notification_Provider.dart';

class NotificationRepository {
  DbHelper helper = DbHelper();
  final NotificationProvider dataProvider;
  NotificationRepository(this.dataProvider);

  Future<List<Notifications>> getNotification() async {
    String accessToken = await helper.getAccessToken();
    try {
      print("reached note repo");
      return dataProvider.getNotification(accessToken);
    } catch (e) {
      print("error in note repo");
      throw (e);
    }
  }

  Future<void> deleteNotification() async {
    return dataProvider.deleteNotification();
  }
}
