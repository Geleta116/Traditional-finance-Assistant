import 'package:equatable/equatable.dart';

import 'package:traditional_financial_asistant/domain/edir/models/models.dart';

abstract class EdirEvent extends Equatable {
  const EdirEvent();
}

class EdirLoad extends EdirEvent {
  const EdirLoad();

  @override
  List<Object> get props => [];
}

class EdirInit extends EdirEvent {
  const EdirInit();

  @override
  List<Object> get props => [];
}

class EdirCreate extends EdirEvent {
  final EdirModel edir;

  const EdirCreate(this.edir);

  @override
  List<Object> get props => [edir];
}

class EdirUpdate extends EdirEvent {
  final int id;
  final EdirModel edir;

  const EdirUpdate(this.id, this.edir);

  @override
  List<Object> get props => [id, edir];
}

// class EdirDelete extends EdirEvent {
//   final int id;

//   const EdirDelete(this.id);

//   @override
//   List<Object> get props => [id];

// }

class makePayement extends EdirEvent {
  final int id;

  const makePayement(this.id);

  @override
  List<Object> get props => [id];
}

class fetchWinner extends EdirEvent {
  final int id;

  const fetchWinner(this.id);

  @override
  List<Object> get props => [id];
}

class join extends EdirEvent {
  final String name;
  final String code;

  const join(this.name, this.code);

  @override
  List<Object> get props => [];
}

class fetchAllMembers extends EdirEvent {
  final int id;

  const fetchAllMembers(this.id);

  @override
  List<Object> get props => [id];
}

// class EdirDelete extends EdirEvent {
//   final int id;

//   const EdirDelete(this.id);

//   @override
//   List<Object> get props => [id];

// }

class getNotification extends EdirEvent {
  final int id;

  const getNotification(this.id);

  @override
  List<Object> get props => [id];
}

class blackList extends EdirEvent {
  final int id;

  const blackList(this.id);

  @override
  List<Object> get props => [id];
}

class deleteMember extends EdirEvent {
  final int id;

  const deleteMember(this.id);

  @override
  List<Object> get props => [id];
}

class deleteNotification extends EdirEvent {
  final int id;

  const deleteNotification(this.id);

  @override
  List<Object> get props => [id];
}
