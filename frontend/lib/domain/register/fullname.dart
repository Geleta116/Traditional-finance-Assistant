import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'AuthFailure.dart';

class FullName extends Equatable {
  final Either<AuthFailure, String> value;

  factory FullName(String input) {
    return FullName._(validateFullName(input));
  }

  const FullName._(this.value);

  static Either<AuthFailure, String> validateFullName(String input) {
   
    if (input.isEmpty) {
      return left(const InvalidFullName());
    } else if (!RegExp(r'^[a-zA-Z_]+$').hasMatch(input)) {
      return left(const InvalidFullNameFormat());
    } else {
      return right(input);
    }
  }
  @override
  List<Object> get props => [value];
}
