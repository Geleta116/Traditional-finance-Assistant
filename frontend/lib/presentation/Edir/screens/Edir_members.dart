import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utilities/User.dart';


class EdirMembersScreen extends StatelessWidget {
  const EdirMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
        centerTitle: true,
      ),

      body:Container(
        width: double.infinity,
        child: buildTable()),
    );
  }
}


List<User> Users = [User(name: 'user1', username: 'user1', joinedAt: DateTime.now().toString()), 
                   User(name: 'user2', username:'user2', joinedAt: DateTime.now().toString( ))];


Widget buildTable() {
  return DataTable(
    dataRowHeight: 50.0, 
    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[300]!),
    columnSpacing: 30.0, 
    columns: [
       DataColumn(
        label: Text(
          'No',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'username',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Joined at',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

    ],
    rows: List.generate(
      Users.length,
      (index) => DataRow(
    
        cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text(Users[index].name)),
          DataCell(
            Text(Users[index].username.toString())),
          DataCell(Text(DateFormat('MMMM d, yyyy').format(DateTime.parse(Users[index].joinedAt)))),
        ],
        color: MaterialStateColor.resolveWith((states) {

          return index % 2 == 0 ? Colors.white : Color(0xff079073);
        }),
      ),
    ),
  );
}
 