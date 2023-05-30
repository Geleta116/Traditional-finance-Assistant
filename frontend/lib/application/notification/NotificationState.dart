import 'dart:developer';

import 'package:equatable/equatable.dart';

import '../../domain/notification/Notification.dart';



abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {}
class NotificationInitial extends NotificationState{}

class NotificationOperationSuccess extends NotificationState {
  final Iterable<Notification> notifications;

  const NotificationOperationSuccess([this.notifications = const []]);

  @override
  List<Object> get props => [notifications];
}

class NotificationOperationFailure extends NotificationState {
  final Object error;

  const NotificationOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}