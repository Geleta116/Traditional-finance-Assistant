import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:traditional_financial_asistant/application/register/signup_bloc.dart';
import 'package:traditional_financial_asistant/application/register/signup_event.dart';
import 'package:traditional_financial_asistant/application/register/signup_state.dart';
import 'package:traditional_financial_asistant/domain/register/Password.dart';
import 'package:traditional_financial_asistant/domain/register/Username.dart';
import 'package:traditional_financial_asistant/domain/register/User.dart';
import 'package:traditional_financial_asistant/domain/register/blance.dart';
import 'package:traditional_financial_asistant/domain/register/email.dart';
import 'package:traditional_financial_asistant/domain/register/fullname.dart';
import 'package:traditional_financial_asistant/domain/register/signUpRepositoryInterface.dart';
import 'package:mockito/annotations.dart';

import 'signUp_bloc_test.mocks.dart';


@GenerateMocks([SignUpRepositoryInterface]) // Specify the classes to generate mocks for

void main() {
  group('SignupBloc', () {
    late SignupBloc signupBloc;
    late MockSignUpRepositoryInterface mockSignUpRepository;

    setUp(() {
      mockSignUpRepository = MockSignUpRepositoryInterface();
      signupBloc = SignupBloc(signupRepository: mockSignUpRepository);
    });

    test('initial state should be SignupInitial', () {
      expect(signupBloc.state, equals(SignupInitial()));
    });

    blocTest<SignupBloc, SignupState>(
      'emits [SignupSuccess] when SignupButtonPressed is added',
      build: () => signupBloc,
      act: (bloc) {
        final user = Users(
          username: Username('testuser'),
          password: Password('Testpassword1#'),
          fullName: FullName('John'),
          balance: Balance('100'),
          email: Email('test@test.com'),
        );
        when(mockSignUpRepository.signUp(user)).thenAnswer((_) async => user);
        bloc.add(SignupButtonPressed(user));
      },
      expect: () => [SignupSuccess(Users(
          username: Username('testuser'),
          password: Password('Testpassword1#'),
          fullName: FullName('John'),
          balance: Balance('100'),
          email: Email('test@test.com'),
        ))],
    );

    blocTest<SignupBloc, SignupState>(
      'emits [SignupFailure] when SignupButtonPressed is added and repository throws an error',
      build: () => signupBloc,
      act: (bloc) {
        final user = Users(
          username: Username('testuser'),
          password: Password('Testpassword1#'),
          fullName: FullName('John'),
          balance: Balance('100'),
          email: Email('test@test.com'),
        );
        when(mockSignUpRepository.signUp(user)).thenThrow(Exception('Test error'));
        bloc.add(SignupButtonPressed(user));
      },
      expect: () => [ SignupFailure('The username is reserved'), SignupInitial()],
    );
  });
}
