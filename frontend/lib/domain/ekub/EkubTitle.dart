import 'package:dartz/dartz.dart';
import 'EkubFailure.dart';

class EkubTitle {
  final Either<EkubFailure, String> value;

  factory EkubTitle(String input) {
    return EkubTitle._(validatetitle(input));
  }

  const EkubTitle._(this.value);

  static Either<EkubFailure, String> validatetitle(String input) {
   
    if (input.isEmpty) {
      return left(const TitleTooShort());
    } else if (input.length < 4) {
      return left(const InvalidTitle());
    } else {
      return right(input);
    }
  }
}
