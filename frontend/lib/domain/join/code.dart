import 'package:dartz/dartz.dart';
import 'JoinFailure.dart';

class JoinCode {
  final Either<JoinFailure, String> value;

  factory JoinCode(String input) {
    return JoinCode._(validatecode(input));
  }

  const JoinCode._(this.value);

  static Either<JoinFailure, String> validatecode(String input) {
   
    if (input.isEmpty) {
      return left(const InvalidCode());
    }  else {
      return right(input);
    }
  }
}
