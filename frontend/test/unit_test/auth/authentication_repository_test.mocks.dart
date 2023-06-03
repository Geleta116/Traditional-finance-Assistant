// Mocks generated by Mockito 5.4.0 from annotations
// in traditional_financial_asistant/test/unit_test/auth/authentication_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i3;
import 'package:traditional_financial_asistant/domain/auth/User.dart' as _i6;
import 'package:traditional_financial_asistant/domain/edir/Edir.dart' as _i9;
import 'package:traditional_financial_asistant/domain/ekub/ekub_barel.dart'
    as _i8;
import 'package:traditional_financial_asistant/domain/register/edirmember.dart'
    as _i11;
import 'package:traditional_financial_asistant/domain/register/memeber_model.dart'
    as _i10;
import 'package:traditional_financial_asistant/infrastructure/auth/accessToken.Dto.dart'
    as _i2;
import 'package:traditional_financial_asistant/infrastructure/auth/authentication_provider.dart'
    as _i4;
import 'package:traditional_financial_asistant/local_storage/local_storage.dart'
    as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAccessTokenDto_0 extends _i1.SmartFake
    implements _i2.AccessTokenDto {
  _FakeAccessTokenDto_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDatabase_1 extends _i1.SmartFake implements _i3.Database {
  _FakeDatabase_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthenticationProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationProvider extends _i1.Mock
    implements _i4.AuthenticationProvider {
  MockAuthenticationProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.AccessTokenDto> logIn(_i6.User? user) => (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [user],
        ),
        returnValue: _i5.Future<_i2.AccessTokenDto>.value(_FakeAccessTokenDto_0(
          this,
          Invocation.method(
            #logIn,
            [user],
          ),
        )),
      ) as _i5.Future<_i2.AccessTokenDto>);
}

/// A class which mocks [DbHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDbHelper extends _i1.Mock implements _i7.DbHelper {
  MockDbHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get version => (super.noSuchMethod(
        Invocation.getter(#version),
        returnValue: 0,
      ) as int);
  @override
  set db(_i3.Database? _db) => super.noSuchMethod(
        Invocation.setter(
          #db,
          _db,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i3.Database> openDb() => (super.noSuchMethod(
        Invocation.method(
          #openDb,
          [],
        ),
        returnValue: _i5.Future<_i3.Database>.value(_FakeDatabase_1(
          this,
          Invocation.method(
            #openDb,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Database>);
  @override
  _i5.Future<int> insertUser(Map<String, dynamic>? accessToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertUser,
          [accessToken],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getUser() => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
        ),
        returnValue: _i5.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i5.Future<List<Map<String, dynamic>>>);
  @override
  _i5.Future<int> deleteUser(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [id],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> insertEkub(List<_i8.Ekub>? ekubList) => (super.noSuchMethod(
        Invocation.method(
          #insertEkub,
          [ekubList],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> insertEdir(List<_i9.Edir>? edirList) => (super.noSuchMethod(
        Invocation.method(
          #insertEdir,
          [edirList],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> updateEkub(Map<String, dynamic>? row) => (super.noSuchMethod(
        Invocation.method(
          #updateEkub,
          [row],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<void> updateEkubList(List<_i8.Ekub>? rows) => (super.noSuchMethod(
        Invocation.method(
          #updateEkubList,
          [rows],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<int> updateEdir(Map<String, dynamic>? row) => (super.noSuchMethod(
        Invocation.method(
          #updateEdir,
          [row],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<void> dropDatabase() => (super.noSuchMethod(
        Invocation.method(
          #dropDatabase,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<int> insertMember(
    List<_i10.Member>? members,
    dynamic name,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertMember,
          [
            members,
            name,
          ],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> insertEdirMember(
    List<_i11.EdirMember>? members,
    dynamic name,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertEdirMember,
          [
            members,
            name,
          ],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
}
