import 'package:flutter_bloc/flutter_bloc.dart';

import '../Ekub_repositories/Ekub_repository.dart';
import 'blocs.dart';

class EkubBloc extends Bloc<EkubEvent, EkubState> {
  final EkubRepository ekubRepository;

  EkubBloc({required this.ekubRepository}) : super(EkubLoading()) {
    on<EkubLoad>((event, emit) async {
      emit(EkubLoading());
      try {
        final ekub = await ekubRepository.fetchAll();
        emit(EkubOperationSuccess(ekub));
      } catch (error) {
        emit(EkubOperationFailure(error));
      }
    });

    on<EkubCreate>((event, emit) async {
      try {
        await ekubRepository.create(event.ekub);
        final ekubs = await ekubRepository.fetchAll();
        emit(EkubOperationSuccess(ekubs));
      } catch (error) {
        emit(EkubOperationFailure(error));
      }
    });

    on<EkubUpdate>((event, emit) async {
      try {
        await ekubRepository.update(event.id, event.ekub);
        final ekubs = await ekubRepository.fetchAll();
        emit(EkubOperationSuccess(ekubs));
      } catch (error) {
        emit(EkubOperationFailure(error));
      }
    });

    on<EkubDelete>((event, emit) async {
      try {
        await ekubRepository.delete(event.id);
        final courses = await ekubRepository.fetchAll();
        emit(EkubOperationSuccess(courses));
      } catch (error) {
        emit(EkubOperationFailure(error));
      }
    });
  }
}