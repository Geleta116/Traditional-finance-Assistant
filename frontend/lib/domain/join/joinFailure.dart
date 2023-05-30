import 'package:equatable/equatable.dart';

class JoinFailure extends Equatable {
  const JoinFailure();

   @override
  List<Object> get props => [];
}


class InvalidName extends JoinFailure {
  const InvalidName();
}

class NameTooShort extends JoinFailure {
  const NameTooShort();
}

class InvalidCode extends JoinFailure {
  const InvalidCode();
}

