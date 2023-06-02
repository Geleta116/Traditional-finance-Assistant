import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/user/User_bloc.dart';
import '../../../application/user/User_state.dart';
import '../../../domain/register/memeber_model.dart';
import 'members.dart';

class BlackListScreen extends StatefulWidget {
  const BlackListScreen({super.key});

  @override
  State<BlackListScreen> createState() => _BlackListScreenState();
}

class _BlackListScreenState extends State<BlackListScreen> {
  List<Member> users = []; // Updated variable name
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          context.goNamed('members');
        
        },
      ),
        title: Text('BlackList'),
        centerTitle: true,
      ),
      body: Container(width: double.infinity, child: buildTable()),
    );
  }

  Widget buildTable() {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserOperationFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Could not do user operation')),
            );
        } else if (state is BlackListMemberOperationSuccess) {

          setState(() {
            users = state.members;
          });
        }
      },
      builder: (context, state) {
        return DataTable(
          dataRowHeight: 50.0,
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => Color.fromARGB(255, 157, 178, 141)),
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
            users.length,
            (index) => DataRow(
              cells: [
                DataCell(Text((index + 1).toString())),
                DataCell(Text(users[index].username == null ? '': users[index].username! )),
                // DataCell(Text(users[index].username.toString())),
              ],
              color: MaterialStateColor.resolveWith((states) {
                return Colors.grey[400]!;
              }),
            ),
          ),
        );
      },
    );
  }
}
