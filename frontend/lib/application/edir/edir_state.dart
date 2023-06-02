import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:traditional_financial_asistant/domain/edir/Edir.dart';

import 'package:traditional_financial_asistant/domain/edir/models/models.dart'; 

abstract class EdirState extends Equatable {
  
  const EdirState();

  @override
  List<Object> get props => [];
}

class EdirLoading extends EdirState {}
class EdirInitial extends EdirState{}
class EdirOperationSuccess extends EdirState {
  final List<EdirModel> edirs;

  const EdirOperationSuccess([this.edirs = const []]);

  @override
  List<Object> get props => [edirs];
}

class EdirOperationFailure extends EdirState {
  final Object error;

  const EdirOperationFailure(this.error);
  @override

  List<Object> get props => [error];
}


class EdirDetailState extends EdirState{
  final Edir edir;

  const EdirDetailState(this.edir);

  @override
  List<Object> get props => [edir];


}
