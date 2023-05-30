
import 'package:equatable/equatable.dart';

abstract class EkubFailure extends Equatable {
  const EkubFailure();

  @override
  List<Object> get props => [];
}

class InvalidTitle extends EkubFailure {
  const InvalidTitle();
}

class TitleTooShort extends EkubFailure {
  const TitleTooShort();
}

class InvalidDescription extends EkubFailure {
  const InvalidDescription();
}

class InvalidNumber extends EkubFailure {
  const InvalidNumber();
}

class DescriptionTooShort extends EkubFailure{
  const DescriptionTooShort();
}


