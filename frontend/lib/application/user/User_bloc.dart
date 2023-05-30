// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../register/models/User.dart';
// import '../domain/Description.dart';
// import '../domain/Ekub.dart';
// import '../domain/EkubFailure.dart';
// import '../domain/EkubTitle.dart';
// import '../domain/validNumber.dart';
// import '../repositories/Ekub_repository.dart';
// import 'blocs.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';

import '../../infrastructure/user/User_repositories.dart';
import 'User_event.dart';
import 'User_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UsersLoad()) {
    on<UserLoad>((event, emit) async {
      try {
        final user = await userRepository.fetchAllMembers(event.id);
        emit(UserLoadedState(user));
      } catch (error) {
        emit(UserOperationFailure("Can't Load Users"));
      }
    });

    on<blackList>((event, emit) async {
      try {
        final user = await userRepository.blackList(event.id);
        emit(UserLoadedState(user));
      } catch (error) {
        emit(UserOperationFailure("Can't Load blackListed users"));
      }
    });

    on<fetchWinner>((event, emit) async {
      try {
        final user = await userRepository.fetchWinner(event.id);
        // emit(UserLoadedState(user));
      } catch (error) {
        emit(UserOperationFailure("Can't Load Users"));
      }
    });
    on<makePayement>((event, emit) async {
      try {
        final user = await userRepository.fetchAllMembers(event.id);
        emit(UserLoadedState(user));
      } catch (error) {
        emit(UserOperationFailure("Can't Load Users"));
      }
    });

    on<getNotification>((event, emit) async {
      try {
        await userRepository.getNotification();
        // emit(UserLoadedState(user));
      } catch (error) {
        emit(UserOperationFailure("Can't Load Users"));
      }
    });
  }
}