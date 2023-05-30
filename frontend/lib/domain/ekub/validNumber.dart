import 'package:dartz/dartz.dart';
import 'EkubFailure.dart';

class ValidNumber {
  final Either<EkubFailure, String> value;

  factory ValidNumber(String input) {
    return ValidNumber._(validatenumber(input));
  }

  const ValidNumber._(this.value);

  static Either<EkubFailure, String> validatenumber(String input) {
    if (input == null) {
      return left(const InvalidNumber());
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(input.toString())) {
      return left(const InvalidNumber());
    } else {
      return right(input);
    }
  }
}
