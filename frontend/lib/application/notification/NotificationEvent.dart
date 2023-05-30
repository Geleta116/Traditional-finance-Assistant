import 'package:equatable/equatable.dart';



abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}



class NotificationLoad extends NotificationEvent {
  const NotificationLoad();

  @override
  List<Object> get props => [];
}

class NotificationDelete extends NotificationEvent {
  final int id;

  const NotificationDelete(this.id);

  @override
  List<Object> get props => [id];
}
