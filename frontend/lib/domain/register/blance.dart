import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'AuthFailure.dart';


class Balance {
  final Either<AuthFailure, String> value;

  factory Balance(String input) {
    return Balance._(validateBalance(input));
  }

  const Balance._(this.value);

  static Either<AuthFailure, String> validateBalance(String input) {
    dynamic myInt = int.parse(input);
    if (input.isEmpty) {
      return left(const InvalidBalance());
    
    } else if (myInt is  !int) {
      return left(const InvalidBalance());
    } else {
      return right(input);
    }
  }
}
