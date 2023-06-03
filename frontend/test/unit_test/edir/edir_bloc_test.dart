import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:traditional_financial_asistant/application/edir/edir_bloc.dart';
import 'package:traditional_financial_asistant/application/edir/edir_state.dart';
import 'package:traditional_financial_asistant/application/edir/edit_event.dart';
import 'package:traditional_financial_asistant/domain/edir/Edir.dart';
import 'package:traditional_financial_asistant/domain/edir/EdirFailure.dart';
import 'package:traditional_financial_asistant/domain/edir/EdirTitle.dart';
import 'package:traditional_financial_asistant/domain/edir/ValidNumber.dart';
import 'package:traditional_financial_asistant/domain/edir/edirRepositoryInterface.dart';
import 'package:traditional_financial_asistant/domain/edir/models/Edir.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir_repository.dart';

import 'edir_bloc_test.mocks.dart';
@GenerateMocks([
  EdirRepositoryInterface,
])
void main() {
  group('EdirBloc', () {
    late EdirBloc edirBloc;
    late MockEdirRepositoryInterface edirRepository;
    final edir = Edir(
      countdown: ValidNumber('10'),
      name: EdirTitle('Test Edir'),
      amount: ValidNumber('100'),
      duration: ValidNumber('30'),
    );
    final edirModel = EdirModel(
      countdown: '10',
      name: 'Test Edir',
      amount: '100',
      duration: '30',
    );

    setUp(() {
      edirRepository = MockEdirRepositoryInterface();
      edirBloc = EdirBloc(edirRepository: edirRepository);
    });

    blocTest<EdirBloc, EdirState>(
      'emits [EdirOperationSuccess] when EdirLoad event is added and fetchAllEnrolled succeeds',
      build: () {
        when(edirRepository.fetchAllEnrolled()).thenAnswer(
          (_) => Future.value([edir]),
        );
        return edirBloc;
      },
      act: (bloc) => bloc.add(EdirLoad()),
      expect: () => [
        EdirInitial(),
        EdirOperationSuccess([edirModel]),
      ],
    );

    blocTest<EdirBloc, EdirState>(
      'emits [EdirOperationFailure] when EdirLoad event is added and fetchAllEnrolled fails',
      build: () {
        when(edirRepository.fetchAllEnrolled()).thenAnswer(
          (_) => Future.error('Fetch failed'),
        );
        return edirBloc;
      },
      act: (bloc) => bloc.add(EdirLoad()),
      expect: () => [
        EdirOperationFailure('Fetch failed'),
      ],
    );
  });
}
