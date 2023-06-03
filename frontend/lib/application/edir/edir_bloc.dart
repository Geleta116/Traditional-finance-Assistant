import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:traditional_financial_asistant/application/edir/edir_state.dart';
import 'package:traditional_financial_asistant/application/edir/edit_event.dart';
import 'package:traditional_financial_asistant/domain/edir/Edir.dart';
import 'package:traditional_financial_asistant/domain/edir/EdirFailure.dart';
import 'package:traditional_financial_asistant/domain/edir/EdirTitle.dart';
import 'package:traditional_financial_asistant/domain/edir/ValidNumber.dart';
import 'package:traditional_financial_asistant/domain/edir/edirRepositoryInterface.dart';
import 'package:traditional_financial_asistant/domain/edir/models/Edir.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir.Dto.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir_repository.dart';

class EdirBloc extends Bloc<EdirEvent, EdirState> {
  final EdirRepositoryInterface edirRepository;

  EdirBloc({required this.edirRepository}) : super(EdirInitial()) {
    on<EdirLoad>((event, emit) async {
      // emit(EdirLoading());R
      print("edir bloc reached");
      try {
        final edir = await edirRepository.fetchAllEnrolled();

        List<EdirModel> edirsList =
            List<EdirModel>.from(edir.map((e) => e.toEdirModel()));
        emit(EdirInitial());
        emit(EdirOperationSuccess(edirsList));
        
      } catch (error) {
        emit(EdirOperationFailure(error));
      }
    });

    on<EdirDelete>((event, emit) async {
      try {
        // emit(EdirLoading());R

        final bool edir = await edirRepository.deleteEdir(event.edir);

        if (edir) {
          print("delete");
          emit(EdirLoading());
        }
      } catch (error) {
        emit(EdirOperationFailure(error));
      }
    });

    on<EdirCreate>((event, emit) async {
      print('edir create bloc');
      EdirTitle name = EdirTitle(event.edir.name);
      ValidNumber amount = ValidNumber(event.edir.amount);
      ValidNumber duration = ValidNumber(event.edir.duration);
      ValidNumber countdown = ValidNumber(event.edir.countdown);

      final edir = Edir.create(
        countdown: countdown,
        name: name,
        amount: amount,
        duration: duration,
      );
      final Either<EdirFailure, Unit> validationResult = edir.validateEdir();
      await validationResult.fold((failure) {
        emit(EdirOperationFailure("wrong input"));
        emit(EdirInitial());
      }, (_) async {
        try {
          await edirRepository.create(edir);
          print("repo has created");
          final edirs = await edirRepository.fetchAllEnrolled();
          List<EdirModel> edirsList =
              List<EdirModel>.from(edirs.map((e) => e.toEdirModel()));

          emit(EdirOperationSuccess(edirsList));
        } catch (error) {
          emit(EdirOperationFailure(error));
        }
      });
    });

    on<EdirUpdate>((event, emit) async {
      ValidNumber countdown = ValidNumber(event.edir.countdown);
      EdirTitle name = EdirTitle(event.edir.name);
      ValidNumber amount = ValidNumber(event.edir.amount);
      ValidNumber duration = ValidNumber(event.edir.duration);

      final edir = Edir.create(
        countdown: countdown,
        name: name,
        amount: amount,
        duration: duration,
      );
      final Either<EdirFailure, Unit> validationResult = edir.validateEdir();
      await validationResult.fold((failure) {
        emit(EdirOperationFailure("wrong input"));
        emit(EdirLoading());
      }, (_) async {
        try {
          await edirRepository.update(event.id, event.edir as Edir);
          final edirs = await edirRepository.fetchAllEnrolled();

          List<EdirModel> edirsList =
              List<EdirModel>.from(edirs.map((e) => e.toEdirModel()));
          emit(EdirOperationSuccess(edirsList));
        } catch (error) {
          emit(EdirOperationFailure(error));
        }
      });
    });

    // on<EdirDelete>((event, emit) async {
    // try {
    //   await edirRepository.delete(event.id);
    //   final courses = await edirRepository.fetchAll();
    //   emit(EdirOperationSuccess(courses));
    // } catch (error) {
    //   emit(EdirOperationFailure(error));
    // }
    // });

    // on<makePayement>((event, emit) async {
    //   try {
    //     await edirRepository.makePayment(event.id);
    //     emit(EdirOperationSuccess());
    //   } catch (error) {
    //     emit(EdirOperationFailure(error));
    //   }
    // });
///////////////////////////////////////////////////////////////////////////////////////
    // on<fetchWinner>((event, emit) async {
    //    try {
    //     User response = await edirRepository.fetchWinner(event.id);
    //     emit(EdirOperationSuccess(User));
    //   } catch (error) {
    //     emit(EdirOperationFailure(error));
    //   }
    // });
/////////////////////////////////////////////////////////////////////////////////////////
    ///
    on<join>((event, emit) async {
      try {
        await edirRepository.join(event.name, event.code);
        emit(EdirOperationSuccess());
      } catch (error) {
        emit(EdirOperationFailure(error));
      }
    });

    on<EdirDetail>((event, emit) async {
      print('here');
      emit(EdirDetailState(event.edir));
    });
  }
}
