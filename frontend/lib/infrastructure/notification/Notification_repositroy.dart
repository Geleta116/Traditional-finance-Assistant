import '../../domain/notification/Notification.dart';
import '../../domain/notification/notification_model.dart';
import 'Notification_Provider.dart';


class NotificationRepository {
  final NotificationProvider dataProvider;
  NotificationRepository(this.dataProvider);

  Future<List<NotificationModel>> getNotification() async {
    return dataProvider.getNotification();
  }

  Future<void> deleteNotification() async {
    return dataProvider.deleteNotification();
  }
}
