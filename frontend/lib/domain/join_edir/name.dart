import 'package:dartz/dartz.dart';
import 'JoinFailure.dart';

class JoinName {
  final Either<JoinFailure, String> value;

  factory JoinName(String input) {
    return JoinName._(validatename(input));
  }

  const JoinName._(this.value);

  static Either<JoinFailure, String> validatename(String input) {
   
    if (input.isEmpty) {
      return left(const InvalidName());
    }  
    else if (input.length < 4) {
      return left(const NameTooShort());
    } else {
      return right(input);
    }
  }
}
