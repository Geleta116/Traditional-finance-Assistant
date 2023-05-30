import 'package:equatable/equatable.dart';


import '../../domain/ekub/models/join.dart';

abstract class JoinEvent extends Equatable {
  const JoinEvent();
}



class JoinInit extends JoinEvent {
  const JoinInit();

  @override
  List<Object> get props => [];
}
class JoinRequest extends JoinEvent {
  final JoinModel Join;

  const JoinRequest(this.Join);

  @override
  List<Object> get props => [Join];
}
