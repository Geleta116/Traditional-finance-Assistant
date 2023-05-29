import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'members.dart';

class EqubDetailNormalUser extends StatelessWidget {
  const EqubDetailNormalUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Create Equb'),
        centerTitle: true,

      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          
                AnnouncementCard(winnerName: 'Winner Name',),
                SizedBox(height: 20.0,),
                Text(
                  'Next round Eligible candidates for lottery',
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                  
                  ),

                SizedBox(height: 20.0,),
                Container(  
                width: double.infinity,
                
                child: buildTable()),
                      ],),
          )

          
        ),)


      
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String winnerName;

  const AnnouncementCard({required this.winnerName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Congratulations to the winner of this month Equb:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              winnerName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
           
          ],
        ),
      ),
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