import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:traditional_financial_asistant/domain/ekub/models/models.dart'; 

abstract class EkubState extends Equatable {
  const EkubState();

  @override
  List<Object> get props => [];
}

class EkubLoading extends EkubState {}
class EkubInitial extends EkubState{}
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