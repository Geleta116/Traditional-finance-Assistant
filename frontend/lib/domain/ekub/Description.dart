import 'package:dartz/dartz.dart';
import 'EkubFailure.dart';

class Description {
  final Either<EkubFailure, String> value;

  factory Description(String input) {
    return Description._(validatedescription(input));
  }

  const Description._(this.value);

  static Either<EkubFailure, String> validatedescription(String input) {
   
    if (input.isEmpty) {
      return left(const InvalidDescription());
    } else if (input.length < 4) {
      return left(const DescriptionTooShort());
    } else {
      return right(input);
    }
  }
}


