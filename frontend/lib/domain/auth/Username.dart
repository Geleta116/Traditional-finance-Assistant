import 'package:dartz/dartz.dart';
import 'AuthFailure.dart';

class Username {
  final Either<AuthFailure, String> value;

  factory Username(String input) {
    return Username._(validateUsername(input));
  }

  const Username._(this.value);

  static Either<AuthFailure, String> validateUsername(String input) {
   
    if (input.isEmpty) {
      return left(const InvalidUsername());
    } else if (input.length < 4) {
      return left(const UsernameTooShort());
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(input)) {
      return left(const InvalidUsernameFormat());
    } else {
      return right(input);
    }
  }
}
