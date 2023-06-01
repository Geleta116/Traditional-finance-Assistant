import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/notification/Notification_repositroy.dart';
import 'NotificationEvent.dart';
import 'NotificationState.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({required this.notificationRepository})
      : super(NotificationInitial()) {
    on<NotificationLoad>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notification = await notificationRepository.getNotification();
        print(notification);
        emit(NotificationOperationSuccess(notification));
      } catch (error) {
        
        emit(NotificationOperationFailure(error));
      }
    });

    on<NotificationDelete>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notification = await notificationRepository.deleteNotification();
        emit(NotificationOperationSuccess());
      } catch (error) {
        emit(NotificationOperationFailure(error));
      }
    });
  }
}
