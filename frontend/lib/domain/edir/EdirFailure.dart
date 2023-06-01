
import 'package:equatable/equatable.dart';

abstract class EdirFailure extends Equatable {
  const EdirFailure();

  @override
  List<Object> get props => [];
}


class InvalidNumber extends EdirFailure {
  const InvalidNumber();
}

class InvalidTitle extends EdirFailure {
  const InvalidTitle();
}

class TitleTooShort extends EdirFailure {
  const TitleTooShort();
}

class InvalidDescription extends EdirFailure {
  const InvalidDescription();
}

class DescriptionTooShort extends EdirFailure{
  const DescriptionTooShort();
}