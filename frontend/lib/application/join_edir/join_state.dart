import 'dart:developer';

import 'package:equatable/equatable.dart';


import '../../domain/ekub/models/join.dart'; 

abstract class JoinEdirState extends Equatable {
  const JoinEdirState();

  @override
  List<Object> get props => [];
}


class JoinInitial extends JoinEdirState{}

class JoinOperationSuccess extends JoinEdirState {
  
  @override
  List<Object> get props => [];
}

class JoinOperationFailure extends JoinEdirState {
  final Object error;

  const JoinOperationFailure(this.error);
  @override
  List<Object> get props => [error.toString()];
}