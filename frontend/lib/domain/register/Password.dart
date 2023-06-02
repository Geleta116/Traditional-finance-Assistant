import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'AuthFailure.dart';


class Password extends Equatable{
  final Either<AuthFailure, String> value;

  factory Password(String input) {
    return Password._(validatePassword(input));
  }

  const Password._(this.value);

  static Either<AuthFailure, String> validatePassword(String input) {
  
    if (input.isEmpty) {
      return left(const InvalidPassword());
    
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(input)) {
      return left(const InvalidPassword());
    } else {
      return right(input);
    }
  }

  @override
  List<Object> get props => [value];
}
