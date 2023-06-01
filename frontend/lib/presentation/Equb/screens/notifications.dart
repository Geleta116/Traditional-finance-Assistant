// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../application/notification/NotificationBloc.dart';
// import '../../../application/notification/NotificationEvent.dart';
// import '../../../application/notification/NotificationState.dart';
// import '../../../domain/notification/notification_model.dart';

// class NotificationsScreen extends StatefulWidget {
//   const NotificationsScreen({super.key});

//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }

// List<NotificationModel> messages = [];

// class _NotificationsScreenState extends State<NotificationsScreen> {
//   @override
//   void initState() {
//     BlocProvider.of<NotificationBloc>(context).add(NotificationLoad());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<NotificationBloc, NotificationState>(
//       listener: (context, state) {
//         if (state is NotificationOperationFailure ){

//         }
//         else if(state is NotificationOperationSuccess){
//           setState(() {
//             messages = state.notifications;
//           });


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

//   Messages({required this.message, required this.date});
// }
