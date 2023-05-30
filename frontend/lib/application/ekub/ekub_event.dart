import 'package:equatable/equatable.dart';

import 'package:traditional_financial_asistant/domain/ekub/models/models.dart';

abstract class EkubEvent extends Equatable {
  const EkubEvent();
}

class EkubLoad extends EkubEvent {
  const EkubLoad();

  @override
  List<Object> get props => [];
}

class EkubInit extends EkubEvent {
  const EkubInit();

  @override
  List<Object> get props => [];
}

class EkubCreate extends EkubEvent {
  final EkubModel ekub;

  const EkubCreate(this.ekub);

  @override
  List<Object> get props => [ekub];
}

class EkubUpdate extends EkubEvent {
  final int id;
  final EkubModel ekub;

  const EkubUpdate(this.id, this.ekub);

  @override
  List<Object> get props => [id, ekub];
}

// class EkubDelete extends EkubEvent {
//   final int id;

//   const EkubDelete(this.id);

//   @override
//   List<Object> get props => [id];

// }

class makePayement extends EkubEvent {
  final int id;

  const makePayement(this.id);

  @override
  List<Object> get props => [id];
}

class fetchWinner extends EkubEvent {
  final int id;

  const fetchWinner(this.id);

  @override
  List<Object> get props => [id];
}

class join extends EkubEvent {
  final String name;
  final String code;

  const join(this.name, this.code);

  @override
  List<Object> get props => [];
}

class fetchAllMembers extends EkubEvent {
  final int id;

  const fetchAllMembers(this.id);

  @override
  List<Object> get props => [id];
}

// class EkubDelete extends EkubEvent {
//   final int id;

//   const EkubDelete(this.id);

//   @override
//   List<Object> get props => [id];

// }

class getNotification extends EkubEvent {
  final int id;

  const getNotification(this.id);

  @override
  List<Object> get props => [id];
}

class blackList extends EkubEvent {
  final int id;

  const blackList(this.id);

  @override
  List<Object> get props => [id];
}

class deleteMember extends EkubEvent {
  final int id;

  const deleteMember(this.id);

  @override
  List<Object> get props => [id];
}

class deleteNotification extends EkubEvent {
  final int id;

  const deleteNotification(this.id);

  @override
  List<Object> get props => [id];
}
