import 'package:equatable/equatable.dart';
import 'package:traditional_financial_asistant/domain/register/register_domain_barell.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  final int id;
  UserLoad(this.id);

  @override
  List<Object> get props => [];
}

class UserInit extends UserEvent {
  const UserInit();

  @override
  List<Object> get props => [];
}

class CurrentUserLoad extends UserEvent {
  const CurrentUserLoad();

  @override
  List<Object> get props => [];
}

class UserUpdate extends UserEvent {
  final int id;
  final Users user;

  const UserUpdate(this.id, this.user);

  @override
  List<Object> get props => [id, user];
}

class deposite extends UserEvent {
  final int money;
  const deposite(this.money);

  @override
  List<Object> get props => [];
}

class makePayement extends UserEvent {
  final String name;

  const makePayement(this.name);
    @override
  List<Object> get props => [name];
}

class fetchWinner extends UserEvent {
  final int id;

  const fetchWinner(this.id);

  @override
  List<Object> get props => [id];
}

// class fetchAllMembers extends UserEvent {
//   final int id;

//   const fetchAllMembers(this.id);

//   @override
//   List<Object> get props => [id];
// }

class getNotification extends UserEvent {
  final int id;

  const getNotification(this.id);

  @override
  List<Object> get props => [id];
}

class blackList extends UserEvent {
  final String name;

  const blackList(this.name);

  @override
  List<Object> get props => [name];
}

class deleteMember extends UserEvent {
  final int id;

  const deleteMember(this.id);

  @override
  List<Object> get props => [id];
}


class AllEdirMemebers extends UserEvent {
  final String name;

  const AllEdirMemebers(this.name);

  @override
  List<Object> get props => [name];
}
class deleteNotification extends UserEvent {
  final int id;

  const deleteNotification(this.id);

  @override
  List<Object> get props => [id];
}

class AllEkubMemebers extends UserEvent {
  final String name;

  const AllEkubMemebers(this.name);

  @override
  List<Object> get props => [name];
}


