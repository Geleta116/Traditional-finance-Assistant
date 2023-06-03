import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:traditional_financial_asistant/domain/ekub/models/models.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/ekub_crate.Dto.dart';

import '../../domain/ekub/Ekub.dart'; 

abstract class EkubState extends Equatable {
  const EkubState();

  @override
  List<Object> get props => [];
}

class EkubLoading extends EkubState {}
class EkubInitial extends EkubState{}
class EkubDetailState extends EkubState{
  final Ekub ekub;

  const EkubDetailState(this.ekub);

  @override
  List<Object> get props => [ekub];
}
class EkubOperationSuccess extends EkubState {
  final List<EkubModel> ekubs;

  const EkubOperationSuccess([this.ekubs = const []]);

  @override
  List<Object> get props => [ekubs];
}

class EkubOperationFailure extends EkubState {
  final Object error;

  const EkubOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
class EkubCreateSuccess extends EkubState {
  final EkubCreateDto ekubCreateDto;

  const EkubCreateSuccess(this.ekubCreateDto);
  @override
  List<Object> get props => [ekubCreateDto];
}