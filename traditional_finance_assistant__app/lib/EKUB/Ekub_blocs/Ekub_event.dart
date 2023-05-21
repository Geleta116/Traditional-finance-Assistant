import 'package:equatable/equatable.dart';

import '../Ekub_models/Ekub.dart';

abstract class EkubEvent extends Equatable {
  const EkubEvent();
}

class EkubLoad extends EkubEvent {
  const EkubLoad();

  @override
  List<Object> get props => [];
}

class EkubCreate extends EkubEvent {
  final Ekub ekub;

  const EkubCreate(this.ekub);

  @override
  List<Object> get props => [ekub];

  @override
  String toString() => 'Ekub Created {ekub Id: ${ekub.id}}';
}

class EkubUpdate extends EkubEvent {
  final int id;
  final Ekub ekub;

  const EkubUpdate(this.id, this.ekub);

  @override
  List<Object> get props => [id, ekub];

  @override
  String toString() => 'Ekub Updated {course Id: ${ekub.id}}';
}

class EkubDelete extends EkubEvent {
  final int id;

  const EkubDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Ekub Deleted {Ekub Id: $id}';

  @override
  bool? get stringify => true;
}