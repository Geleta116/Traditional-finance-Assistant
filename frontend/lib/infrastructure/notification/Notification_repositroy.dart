import '../../domain/notification/Notification.dart';
import 'Notification_Provider.dart';


class NotificationRepository {
  final NotificationProvider dataProvider;
  NotificationRepository(this.dataProvider);

  Future<List<Notification>> getNotification() async {
    return dataProvider.getNotification();
  }

  Future<void> deleteNotification() async {
    return dataProvider.deleteNotification();
  }
}
