import 'package:flutter/material.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

List<Messages> messages = [
  Messages(message: 'You have been added to the group', date: '12/12/2021'),
  Messages(message:'You have to pay 1000 birr', date: '12/12/2021'),
 
];

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications') ,
      ),
      body:Container(
        child:Center(
          child:Column(
            children: [
            Flexible(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index){
                final item = messages[index];
                return Dismissible(
                  key: Key(item.message),
                  onDismissed: (direction){
                    setState(() {
                      messages.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.message} dismissed')));
                  },
                  child: ListTile(
                      title: Text(messages[index].message),
                      subtitle: Text(messages[index].date),
                      
                    ),
                );
                
              },
            ),
          )
            ],
          )
         
        ),)
      
      
      );
  }
}

class Messages {

  final String message;
  final String date;

  Messages({required this.message, required this.date});
 
}