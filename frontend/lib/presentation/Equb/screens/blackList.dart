import 'package:flutter/material.dart';

import 'members.dart';

class BlackListScreen extends StatelessWidget {
  const BlackListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BlackList'),
        centerTitle: true,
      ),
      body: Container(  
        width: double.infinity,
        
        child: buildTable()),
    );
  }
}


Widget buildTable() {
  return DataTable(
    dataRowHeight: 50.0, 
    headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 157, 178, 141)),
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
     
    ],
    rows: List.generate(
      Users.length,
      (index) => DataRow(
    
        cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text(Users[index].name)),
          DataCell(
            Text(Users[index].username.toString())),
        ],
        color: MaterialStateColor.resolveWith((states) {

          return Colors.grey[400]!;
        }),
      ),
    ),
  );
}