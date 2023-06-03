// Mocks generated by Mockito 5.4.0 from annotations
// in traditional_financial_asistant/test/unit_test/notification/notification_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:traditional_financial_asistant/domain/notification/Notification.dart'
    as _i6;
import 'package:traditional_financial_asistant/infrastructure/notification/Notification_Provider.dart'
    as _i3;
import 'package:traditional_financial_asistant/infrastructure/notification/Notification_repositroy.dart'
    as _i4;
import 'package:traditional_financial_asistant/local_storage/local_storage.dart'
    as _i2;

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

class _FakeDbHelper_0 extends _i1.SmartFake implements _i2.DbHelper {
  _FakeDbHelper_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNotificationProvider_1 extends _i1.SmartFake
    implements _i3.NotificationProvider {
  _FakeNotificationProvider_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NotificationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationRepository extends _i1.Mock
    implements _i4.NotificationRepository {
  MockNotificationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DbHelper get helper => (super.noSuchMethod(
        Invocation.getter(#helper),
        returnValue: _FakeDbHelper_0(
          this,
          Invocation.getter(#helper),
        ),
      ) as _i2.DbHelper);
  @override
  set helper(_i2.DbHelper? _helper) => super.noSuchMethod(
        Invocation.setter(
          #helper,
          _helper,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.NotificationProvider get dataProvider => (super.noSuchMethod(
        Invocation.getter(#dataProvider),
        returnValue: _FakeNotificationProvider_1(
          this,
          Invocation.getter(#dataProvider),
        ),
      ) as _i3.NotificationProvider);
  @override
  _i5.Future<List<_i6.Notifications>> getNotification() => (super.noSuchMethod(
        Invocation.method(
          #getNotification,
          [],
        ),
        returnValue:
            _i5.Future<List<_i6.Notifications>>.value(<_i6.Notifications>[]),
      ) as _i5.Future<List<_i6.Notifications>>);
}
