import 'package:equatable/equatable.dart';


import '../../domain/ekub/models/join.dart';

abstract class JoinEdirEvent extends Equatable {
  const JoinEdirEvent();
}



class JoinEdirInit extends JoinEdirEvent {
  const JoinEdirInit();

  @override
  List<Object> get props => [];
}
class JoinEdirRequest extends JoinEdirEvent {
  final JoinModel Join;

  const JoinEdirRequest(this.Join);

  @override
  List<Object> get props => [Join];
}
