import 'package:equatable/equatable.dart';

import 'NotificationFailure.dart';
import 'Username.dart';
import 'Message.dart';

import 'package:dartz/dartz.dart';

class Notifications  extends Equatable{
  final Username username;
  final Message message;

  Notifications({required this.username, required this.message});

  factory Notifications.create(
      {required Username username, required Message message}) {
    return Notifications(username: username, message: message);
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

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
        username: Username(json['username']),
        message: Message(json['message']));

  }

  @override
  List<Object> get props => [username, message];
}
