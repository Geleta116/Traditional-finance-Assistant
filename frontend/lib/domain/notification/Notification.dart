import 'NotificationFailure.dart';
import 'Username.dart';
import 'Message.dart';

import 'package:dartz/dartz.dart';

class Notification {
  final Username username;
  final Message message;

  Notification({required this.username, required this.message});

  factory Notification.create(
      {required Username username, required Message message}) {
    return Notification(username: username, message: message);
  }

  Either<NotificationFailure, Unit> validateCredentials() {
    if (username.value.isLeft()) {
      return left(InvalidUsername());
    } else if (message.value.isLeft()) {
      return left(InvalidMessage());
    } else {
      return right(unit);
    }
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        username: Username(json['username']),
        message: Message(json['message']));

  }
}
