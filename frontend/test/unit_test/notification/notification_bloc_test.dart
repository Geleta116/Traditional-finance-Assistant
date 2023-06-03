import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:traditional_financial_asistant/application/notification/NotificationBloc.dart';
import 'package:traditional_financial_asistant/application/notification/NotificationEvent.dart';
import 'package:traditional_financial_asistant/application/notification/NotificationState.dart';
import 'package:traditional_financial_asistant/domain/notification/Message.dart';
import 'package:traditional_financial_asistant/domain/notification/Notification.dart';
import 'package:traditional_financial_asistant/domain/notification/Username.dart';
import 'package:traditional_financial_asistant/infrastructure/notification/Notification_repositroy.dart';

import 'notification_bloc_test.mocks.dart';


@GenerateMocks([NotificationRepository]) // Specify the classes to generate mocks for

void main() {
  group('NotificationBloc', () {
    late NotificationBloc notificationBloc;
    late MockNotificationRepository mockNotificationRepository;

    setUp(() {
      mockNotificationRepository = MockNotificationRepository();
      notificationBloc = NotificationBloc(notificationRepository: mockNotificationRepository);
    });

    test('initial state should be NotificationInitial', () {
      expect(notificationBloc.state, equals(NotificationInitial()));
    });

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationOperationSuccess] when NotificationLoad is added',
      build: () => notificationBloc,
      act: (bloc) {
        final notifications = [Notifications(username: Username('user1'), message: Message('Notification 1'))];
        when(mockNotificationRepository.getNotification()).thenAnswer((_) async => notifications);
        bloc.add(NotificationLoad());
      },
      expect: () => [NotificationLoading(), NotificationOperationSuccess([Notifications(username: Username('user1'), message: Message('Notification 1'))])],
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationOperationFailure] when NotificationLoad is added and repository throws an error',
      build: () => notificationBloc,
      act: (bloc) {
        when(mockNotificationRepository.getNotification()).thenThrow(Exception('Test error'));
        bloc.add(NotificationLoad());
      },
      expect: () => [NotificationLoading(), NotificationOperationFailure(Exception('Test error'))],
    );


  });
}
