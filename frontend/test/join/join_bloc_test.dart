import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:mockito/annotations.dart';
import 'package:traditional_financial_asistant/application/join/join_bloc.dart';
import 'package:traditional_financial_asistant/application/join/join_event.dart';
import 'package:traditional_financial_asistant/application/join/join_state.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/join.dart';
import 'package:traditional_financial_asistant/domain/join/joinRepositoryInterface.dart';

import 'join_bloc_test.mocks.dart';

@GenerateMocks([JoinRepositoryInterface]) // Specify the classes to generate mocks for

void main() {
  group('JoinBloc', () {
    late JoinBloc joinBloc;
    late MockJoinRepositoryInterface mockJoinRepository;

    setUp(() {
      mockJoinRepository = MockJoinRepositoryInterface();
      joinBloc = JoinBloc(joinRepository: mockJoinRepository);
    });

    test('initial state should be JoinInitial', () {
      expect(joinBloc.state, equals(JoinInitial()));
    });

    blocTest<JoinBloc, JoinState>(
      'emits [JoinOperationSuccess] when JoinRequest is added',
      build: () => joinBloc,
      act: (bloc) {
        when(mockJoinRepository.joined(any)).thenAnswer((_) async => null);
        bloc.add(JoinRequest(JoinModel(name: 'John', code: '123')));
      },
      expect: () => [JoinOperationSuccess()],
    );

    blocTest<JoinBloc, JoinState>(
      'emits [JoinOperationFailure] when JoinRequest is added and repository throws an error',
      build: () => joinBloc,
      act: (bloc) {
        when(mockJoinRepository.joined(any)).thenThrow(Exception('Test error'));
        bloc.add(JoinRequest(JoinModel(name: 'John', code: '123')));
      },
      expect: () => [JoinOperationFailure(Exception('Test error'))],
    );
  });
}
