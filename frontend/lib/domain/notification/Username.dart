import 'package:dartz/dartz.dart';
import 'NotificationFailure.dart';

class Username {
  final Either<NotificationFailure, String> value;

  factory Username(String input) {
    return Username._(validateUsername(input));
  }

  const Username._(this.value);

  static Either<NotificationFailure, String> validateUsername(String input) {
   
    if (input.isEmpty) {
      return left(InvalidUsername());
    } else if (input.length < 4) {
      return left(UsernameTooShort());
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(input)) {
      return left(InvalidUsernameFormat());
    } else {
      return right(input);
    }
  }
}
