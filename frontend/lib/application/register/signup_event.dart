import 'package:equatable/equatable.dart';

import '../../domain/register/User.dart';


abstract class SignupEvent extends Equatable {
  const SignupEvent();

  
}

class SignupButtonPressed extends SignupEvent {
  final Users user;
  
  const SignupButtonPressed(this.user);

  @override
  List<Object?> get props => [user];

  // @override
  // String toString() => 'user Created {user Id:}';
}


