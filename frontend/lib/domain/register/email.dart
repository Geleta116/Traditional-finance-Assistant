import 'package:dartz/dartz.dart';
import 'AuthFailure.dart';

class Email {
  final Either<AuthFailure, String> value;

  factory Email(String input) {
    return Email._(validateEmail(input));
  }

  const Email._(this.value);

  static Either<AuthFailure, String> validateEmail(String input) {
   
    if (input.isEmpty) {
      return left(const InvalidEmail());
    }
    //  else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(input)) {
    //   return left(const InvalidEmailFormat());
    // } 
    else {
      return right(input);
    }
  }
}
