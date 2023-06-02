import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:traditional_financial_asistant/application/auth/authentication_bloc.dart';
import 'package:traditional_financial_asistant/domain/auth/User.dart';
import 'package:traditional_financial_asistant/domain/auth/authenticationRepositoryInterface.dart';
import 'package:traditional_financial_asistant/domain/auth/password.dart';
import 'package:traditional_financial_asistant/domain/auth/username.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationRepositroyInterface])
void main() {
  // ...

  group('AuthenticationBloc', () {
    AuthenticationBloc? authenticationBloc;
    MockAuthenticationRepositroyInterface? mockRepository;

    setUp(() {
      mockRepository = MockAuthenticationRepositroyInterface();
      authenticationBloc = AuthenticationBloc(mockRepository!);
    });

    tearDown(() {
      authenticationBloc!.close();
    });

    test('initial state is AuthenticationInitial', () {
      expect(authenticationBloc!.state, AuthenticationInitial());
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationFailure, AuthenticationInitial] when LoginEvent is added and credentials are invalid',
      build: () => authenticationBloc!,
      act: (bloc) => bloc.add(LoginEvent(User(
        username: Username('invalid'),
        password: Password('password'),
      ))),
      expect: () => [
        AuthenticationFailure(),
        AuthenticationInitial(),
      ],
    );

blocTest<AuthenticationBloc, AuthenticationState>(
    'emits [AuthenticationAuthenticated] when LoginEvent is added and credentials are valid',
    setUp: () {
      when(mockRepository!.logIn(any)).thenAnswer((_) => Future.value());
    },
    build: () => authenticationBloc!,
    act: (bloc) => bloc.add(LoginEvent(User(
      username: Username('valid_username'),
      password: Password('ValidPassword1'),
    ))),
    expect: () => [
      AuthenticationAuthenticated(),
    ],
    // verify: (_) {
    //   final expectedUser = User(
    //     username: Username('valid_username'),
    //     password: Password('ValidPassword1'),
    //   );
    //   verify(mockRepository!.logIn(expectedUser)).called(1);
    // },
  );

  });

// ...

}
