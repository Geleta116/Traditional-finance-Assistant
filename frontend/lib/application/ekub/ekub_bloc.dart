import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traditional_financial_asistant/domain/ekub/Description.dart';
import 'package:traditional_financial_asistant/domain/ekub/Ekub.dart';
import 'package:traditional_financial_asistant/domain/ekub/EkubFailure.dart';
import 'package:traditional_financial_asistant/domain/ekub/EkubTitle.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/Ekub.dart';
import 'package:traditional_financial_asistant/domain/ekub/validNumber.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/ekub_repository.dart';
import 'blocs.dart';
import 'package:traditional_financial_asistant/domain/ekub/Ekub.dart';
import 'package:traditional_financial_asistant/domain/ekub/ekubRepositoryInterface.dart';

class EkubBloc extends Bloc<EkubEvent, EkubState> {
  final EkubRepositoryInterface ekubRepository;

  EkubBloc({required this.ekubRepository}) : super(EkubLoading()) {
    on<EkubLoad>((event, emit) async {
      emit(EkubLoading());
      try {
        print('ekub block');
        final ekubs = await ekubRepository.fetchAllEnrolled();
        List<EkubModel> ekubsList =
            List<EkubModel>.from(ekubs.map((e) => e.toEqubModel()));

        emit(EkubOperationSuccess(ekubsList));
      } catch (error) {
        emit(EkubOperationFailure(error));
      }
    });

    on<EkubCreate>((event, emit) async {

      Description description = Description(event.ekub.description);
      EkubTitle name = EkubTitle(event.ekub.name);
      ValidNumber amount = ValidNumber(event.ekub.amount);
      ValidNumber minMembers = ValidNumber(event.ekub.minMembers);
      ValidNumber countdown = ValidNumber(event.ekub.countdown);
      ValidNumber duration = ValidNumber(event.ekub.duration);
      print('ekub block');

      final ekub = Ekub.create(
          description: description,
          name: name,
          amount: amount,
          minMembers: minMembers,
          duration: duration,
          countdown: countdown);
      print(ekub);
      final Either<EkubFailure, Unit> validationResult = ekub.validateEkub();
      await validationResult.fold((failure) {
        emit(EkubOperationFailure("wrong input"));
        emit(EkubInitial());
      }, (_) async {
        try {
          await ekubRepository.create(ekub);
          final List<Ekub> ekubs = await ekubRepository.fetchAllEnrolled();

          List<EkubModel> ekubsList =
              List<EkubModel>.from(ekubs.map((e) => e.toEqubModel()));

          emit(EkubOperationSuccess(ekubsList));
        } catch (error) {
          emit(EkubOperationFailure(error));
        }
      });
    });

    on<EkubUpdate>((event, emit) async {
      Description description = Description(event.ekub.description);
      EkubTitle name = EkubTitle(event.ekub.name);
      ValidNumber amount = ValidNumber(event.ekub.amount);
      ValidNumber minMembers = ValidNumber(event.ekub.minMembers);
      ValidNumber countdown = ValidNumber(event.ekub.countdown);
      ValidNumber duration = ValidNumber(event.ekub.duration);

      final ekub = Ekub.create(
          description: description,
          name: name,
          amount: amount,
          minMembers: minMembers,
          duration: duration,
          countdown: countdown);
      final Either<EkubFailure, Unit> validationResult = ekub.validateEkub();
      await validationResult.fold((failure) {
        emit(EkubOperationFailure("wrong input"));
        emit(EkubLoading());
      }, (_) async {
        try {
          await ekubRepository.update(event.id, ekub);
          final ekubs = await ekubRepository.fetchAllEnrolled();

          List<EkubModel> ekubsList =
              ekubs.map((e) => e.toEqubModel()).toList() as List<EkubModel>;
          emit(EkubOperationSuccess(ekubsList));
        } catch (error) {
          emit(EkubOperationFailure(error));
        }
      });
    });

    // on<EkubDelete>((event, emit) async {
    // try {
    //   await ekubRepository.delete(event.id);
    //   final courses = await ekubRepository.fetchAll();
    //   emit(EkubOperationSuccess(courses));
    // } catch (error) {
    //   emit(EkubOperationFailure(error));
    // }
    // });

    // on<makePayement>((event, emit) async {
    //   try {
    //     await ekubRepository.makePayment(event.id);
    //     emit(EkubOperationSuccess());
    //   } catch (error) {
    //     emit(EkubOperationFailure(error));
    //   }
    // });
///////////////////////////////////////////////////////////////////////////////////////
    // on<fetchWinner>((event, emit) async {
    //    try {
    //     User response = await ekubRepository.fetchWinner(event.id);
    //     emit(EkubOperationSuccess(User));
    //   } catch (error) {
    //     emit(EkubOperationFailure(error));
    //   }
    // });
/////////////////////////////////////////////////////////////////////////////////////////
    ///
    on<join>((event, emit) async {
      try {
        await ekubRepository.join(event.name, event.code);
        emit(EkubOperationSuccess());
      } catch (error) {
        emit(EkubOperationFailure(error));
      }
    });
    on<EkubDetail>((event, emit) async {
      print('here');
      emit(EkubDetailState(event.ekub));
    });
  }
}
