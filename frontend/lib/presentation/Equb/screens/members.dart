import 'package:flutter/material.dart';

import '../utilities/User.dart';


class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

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


List<User> Users = [User(name: 'user1', username: 'user1', haveWon: true), 
                   User(name: 'user2', username:'user2', haveWon: false)];


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
          'haveWon',
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
          DataCell(Text(Users[index].haveWon? 'yes': 'no')),
        ],
        color: MaterialStateColor.resolveWith((states) {

          return index % 2 == 0 ? Colors.white : Color(0xff079073);
        }),
      ),
    ),
  );
}