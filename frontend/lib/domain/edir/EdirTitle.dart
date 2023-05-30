import 'package:dartz/dartz.dart';
import 'EdirFailure.dart';

class EdirTitle {
  final Either<EdirFailure, String> value;

  factory EdirTitle(String input) {
    return EdirTitle._(validatetitle(input));
  }

  const EdirTitle._(this.value);

  static Either<EdirFailure, String> validatetitle(String input) {
   
    if (input.isEmpty) {
      return left(const TitleTooShort());
    } else if (input.length < 4) {
      return left(const InvalidTitle());
    } else {
      return right(input);
    }
  }
}
