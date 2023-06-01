import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traditional_financial_asistant/application/notification/NotificationBloc.dart';
import 'package:traditional_financial_asistant/application/notification/NotificationEvent.dart';
import 'package:traditional_financial_asistant/application/notification/NotificationState.dart';
import 'package:traditional_financial_asistant/domain/notification/Notification.dart';

//         }
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         return Scaffold(
//             appBar: AppBar(
//               title: Text('Notifications'),
//             ),
//             body: Container(
//               child: Center(
//                   child: Column(
//                 children: [
//                   Flexible(
//                     child: ListView.builder(
//                       itemCount: messages.length,
//                       itemBuilder: (context, index) {
//                         final item = messages[index];
//                         return Dismissible(
//                           key: Key(item.message),
//                           onDismissed: (direction) {
//                             setState(() {
//                               messages.removeAt(index);
//                             });
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: Text('${item.messages} dismissed')));
//                           },
//                           child: ListTile(
//                             title: Text(messages[index].message),
//                             // subtitle: Text(messages[index].date),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               )),
//             ));
//       },
//     );
//   }
// }

// class Messages {
//   final String message;
//   final String date;

// List<Messages> messages = [
//   Messages(message: 'You have been added to the group', date: '12/12/2021'),
//   Messages(message:'You have to pay 1000 birr', date: '12/12/2021'),

// ];

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationScreen> {
  void initState() {
    super.initState();

    final NotificationEvent event = NotificationLoad();
    BlocProvider.of<NotificationBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationOperationSuccess) {
              List<Notifications> message = state.notifications;
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is NotificationOperationSuccess) {
              List<Notifications> messages = state.notifications;

              return Container(
                child: Center(
                    child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final item = messages[index];
                          return Dismissible(
                            key: Key(item.message.value.getOrElse(() => "")),
                            onDismissed: (direction) {
                              setState(() {
                                messages.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('${item.message} dismissed')));
                            },
                            child: ListTile(
                              title: Text(messages[index].message.value.getOrElse(() => "")),
                              // subtitle: Text(messages[index].date),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )),
              );
            } else {
              return Text("no notifications so far");
            }
          },
        ));
  }
}

class Messages {
  final String message;
  final String date;

  Messages({required this.message, required this.date});
}
