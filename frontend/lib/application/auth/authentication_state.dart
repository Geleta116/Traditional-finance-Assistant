part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}
class AuthenticationFailure extends AuthenticationState {}

