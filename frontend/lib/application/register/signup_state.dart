import 'package:equatable/equatable.dart';
import '';
import '../../domain/register/User.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final Users user;
  

  SignupSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignupFailure extends SignupState {
  final String errorMessage;

  SignupFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

