import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traditional_financial_asistant/domain/join/code.dart';
//import 'package:traditional_financial_asistant/domain/join/Join.dart';
import 'package:traditional_financial_asistant/domain/join/join.dart';
import 'package:traditional_financial_asistant/domain/join/joinFailure.dart';
import 'package:traditional_financial_asistant/domain/join/name.dart';

import '../../domain/join/joinRepositoryInterface.dart';
import 'join_event.dart';
import 'join_state.dart';

class JoinEdirBloc extends Bloc<JoinEdirEvent, JoinEdirState> {
  final JoinRepositoryInterface joinRepository;

  JoinEdirBloc({required this.joinRepository}) : super(JoinInitial()) {
    on<JoinEdirRequest>((event, emit) async {
      JoinName name = JoinName(event.Join.name);
      JoinCode code = JoinCode(event.Join.code);
      final edir = Join.create(
          name: name,
          code: code);
      final Either<JoinFailure, Unit> validationResult = edir.validateJoin();
      await validationResult.fold((failure) {
        emit(JoinOperationFailure("wrong input"));
        emit(JoinInitial());
      },(_) async {
      try {
        print("reached join bloc");
        await joinRepository.joined(edir);
        emit(JoinOperationSuccess());
      } catch (error) {
        print("reached join bloc BUT RETURNED ERROR");
        print(error);
        emit(JoinOperationFailure(error));
      }
    });});
  }
}
