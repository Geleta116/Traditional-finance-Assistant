import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/register/AuthFailure.dart';
import '../../domain/register/Password.dart';
import '../../domain/register/Username.dart';
import '../../domain/register/User.dart';
import '../../domain/register/blance.dart';
import '../../domain/register/email.dart';
import '../../domain/register/fullname.dart';
import '../../domain/register/signUpRepositoryInterface.dart';
import '../../infrastructure/register/signup_repository.dart';
import '../../application/register/signup_event.dart';
import '../../application/register/signup_state.dart';
import '../../domain/register/User.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpRepositoryInterface signupRepository;

  SignupBloc({required this.signupRepository}) : super(SignupInitial()) {
    on<SignupButtonPressed>((event, emit) async {
      Username username = event.user.username;
      Password password = event.user.password;
      FullName fullName = event.user.fullName;
      Balance balance = event.user.balance;
      Email email = event.user.email;

      final user = Users.create(username: username, password: password,fullName: fullName, balance: balance, email: email);
      final Either<AuthFailure, Unit> validationResult =
          user.validateCredentials();

      await validationResult.fold((failure) {
        emit(SignupFailure("wrong input"));
        emit(SignupInitial());
      }, (_) async {
        try {
          final result = await signupRepository.signUp(event.user);

          emit(SignupSuccess(result as Users));
        } catch (error) {
          emit(SignupFailure('The username is reserved'));
          emit(SignupInitial());
        }
      });
    });
  }
}
