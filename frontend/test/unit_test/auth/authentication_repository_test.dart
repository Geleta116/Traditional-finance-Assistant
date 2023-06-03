import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:traditional_financial_asistant/domain/auth/User.dart';
import 'package:traditional_financial_asistant/domain/auth/Password.dart';
import 'package:traditional_financial_asistant/domain/auth/username.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/accessToken.Dto.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/authentication_provider.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/authentication_repository.dart';
import 'package:traditional_financial_asistant/local_storage/local_storage.dart';

import 'authentication_repository_test.mocks.dart';


// Use the @GenerateMocks annotation to generate mock classes
@GenerateMocks([AuthenticationProvider, DbHelper])
void main() {
  late AuthenticationRepository repository;
  late MockAuthenticationProvider mockAuthProvider;
  late MockDbHelper mockDbHelper;

  setUp(() {
    mockAuthProvider = MockAuthenticationProvider();
    mockDbHelper = MockDbHelper();
    repository = AuthenticationRepository(mockAuthProvider, passedDB: mockDbHelper);
  });

  group('AuthenticationRepository', () {


    test('logIn should throw an exception if an error occurs', () async {
      final user = User(username: Username('testuser'), password: Password('password'));

      when(mockAuthProvider.logIn(user)).thenThrow(Exception('Error'));

      expect(() => repository.logIn(user), throwsException);
    });

    test('loggedIn should return Right with 1 if access token is found', () async {
      when(mockDbHelper.getAccessToken()).thenAnswer((_) async {});

      final result = await repository.loggedIn();

      expect(result, equals(Right(1)));
      verify(mockDbHelper.getAccessToken()).called(1);
    });

    test('loggedIn should return Left with "access token not found" if access token is not found', () async {
      when(mockDbHelper.getAccessToken()).thenThrow(Exception('Error'));

      final result = await repository.loggedIn();

      expect(result, equals(Left('access token not found')));
      verify(mockDbHelper.getAccessToken()).called(1);
    });
  });
}
