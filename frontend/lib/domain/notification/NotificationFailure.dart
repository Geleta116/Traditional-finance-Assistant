import 'package:equatable/equatable.dart';

abstract class NotificationFailure extends Equatable {
  const NotificationFailure();
  @override
  List<Object> get props => [];
}

class InvalidUsername extends NotificationFailure {
  InvalidUsername();
}

class UsernameTooShort extends NotificationFailure {
  UsernameTooShort();
}

class InvalidUsernameFormat extends NotificationFailure {
  InvalidUsernameFormat();
}

class InvalidMessage extends NotificationFailure {
  const InvalidMessage();
}



// class InvalidUsername extends UserFailure {
//   const InvalidUsername();
// }

// class UsernameTooShort extends UserFailure {
//   const UsernameTooShort();
// }

// class InvalidEmail extends UserFailure {
//   const InvalidEmail();
// }

// class InvalidEmailFormat extends UserFailure {
//   const InvalidEmailFormat();
// }

// class InvalidUsernameFormat extends UserFailure {
//   const InvalidUsernameFormat();
// }

// class InvalidPassword extends UserFailure {
//   const InvalidPassword();
// }

// class InvalidBalance extends UserFailure {
//   const InvalidBalance();
// }

// class InvalidFullName extends UserFailure {
//   const InvalidFullName();
// }

// class InvalidFullNameFormat extends UserFailure {
//   const InvalidFullNameFormat();
// }