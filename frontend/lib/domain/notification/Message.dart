import 'package:dartz/dartz.dart';
import 'NotificationFailure.dart';

class Message {
  final Either<NotificationFailure, String> value;

  factory Message(String input) {
    return Message._(validateMessage(input));
  }

  const Message._(this.value);

  static Either<NotificationFailure, String> validateMessage(String input) {
   
    if (input.isEmpty) {
      return left(InvalidUsername());
    } else if (input.length < 4) {
      return left(UsernameTooShort());
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(input)) {
      return left(InvalidUsernameFormat());
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(input)) {
      return left(InvalidMessage());
    }else {
      return right(input);
    }
  }
}
