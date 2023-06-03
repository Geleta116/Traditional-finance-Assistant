import 'dart:developer';

import 'package:equatable/equatable.dart';


import '../../domain/ekub/models/join.dart'; 

abstract class JoinState extends Equatable {
  const JoinState();

  @override
  List<Object> get props => [];
}


class JoinInitial extends JoinState{}

class JoinOperationSuccess extends JoinState {
  
  @override
  List<Object> get props => [];
}

class JoinOperationFailure extends JoinState {
  final Object error;

  const JoinOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}