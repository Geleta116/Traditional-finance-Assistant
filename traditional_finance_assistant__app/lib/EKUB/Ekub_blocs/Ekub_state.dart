import 'package:equatable/equatable.dart';

import '../Ekub_models/Ekub.dart';

abstract class EkubState extends Equatable {
  const EkubState();

  @override
  List<Object> get props => [];
}

class EkubLoading extends EkubState {}

class EkubOperationSuccess extends EkubState {
  final Iterable<Ekub> ekubs;

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