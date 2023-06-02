import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:traditional_financial_asistant/application/join_edir/join_bloc.dart';
import 'package:traditional_financial_asistant/application/join_edir/join_event.dart';
import 'package:traditional_financial_asistant/application/join_edir/join_state.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/join.dart';
import 'package:traditional_financial_asistant/domain/join/joinRepositoryInterface.dart';

import 'join_edir_bloc.mocks.dart';


@GenerateMocks([JoinRepositoryInterface]) 

void main() {
  group('JoinEdirBloc', () {
    late JoinEdirBloc joinEdirBloc;
    late MockJoinRepositoryInterface mockJoinRepository;

    setUp(() {
      mockJoinRepository = MockJoinRepositoryInterface();
      joinEdirBloc = JoinEdirBloc(joinRepository: mockJoinRepository);
    });

    test('initial state should be JoinInitial', () {
      expect(joinEdirBloc.state, equals(JoinInitial()));
    });

    blocTest<JoinEdirBloc, JoinEdirState>(
      'emits [JoinOperationSuccess] when JoinEdirRequest is added',
      build: () => joinEdirBloc,
      act: (bloc) {
        when(mockJoinRepository.joined(any)).thenAnswer((_) async => null);
        bloc.add(JoinEdirRequest(JoinModel(name: 'John', code: '123')));
      },
      expect: () => [JoinOperationSuccess()],
    );

    blocTest<JoinEdirBloc, JoinEdirState>(
      'emits [JoinOperationFailure] when JoinEdirRequest is added and repository throws an error',
      build: () => joinEdirBloc,
      act: (bloc) {
        when(mockJoinRepository.joined(any)).thenThrow(Exception('Test error'));
        bloc.add(JoinEdirRequest(JoinModel(name: 'John', code: '123')));
      },
      expect: () => [JoinOperationFailure(Exception('Test error'))],
    );
  });
}
