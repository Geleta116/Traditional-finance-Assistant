import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:traditional_financial_asistant/application/user/User_bloc.dart';
import 'package:traditional_financial_asistant/application/user/User_state.dart';

import '../../../domain/register/edirmember.dart';
// import 'package:traditional_financial_asistant/domain/register/edirmember_model.dart';
// import 'package:traditional_financial_asistant/domain/register/memeber_model.dart';

// import '../../Edir presentaion/utilities/User.dart';

class EdirMemberScreen extends StatefulWidget {
  const EdirMemberScreen({super.key});

  @override
  State<EdirMemberScreen> createState() => _EdirMemberScreenState();
}

class _EdirMemberScreenState extends State<EdirMemberScreen> {
  List<EdirMember> members = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                context.goNamed('edirCreater');
              },
            ),
        title: Text('Edir Members'),
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
        } else if (state is EdirMemberOperationSuccess) {
          print(state.members[0].username);
          setState(() {
            members = state.members;
          });
        }
      },
      builder: (context, state) {
         if (state is UserOperationFailure) {
          return Text('Could not do user operation');
        }
        return DataTable(
          dataRowHeight: 50.0,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey[300]!),
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
                'UserName',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'penality',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'paid',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: List.generate(
            members.length,
            (index) => DataRow(
              cells: [
                DataCell(Text((index + 1).toString())),
                DataCell(Text(members[index].username!)),
                 DataCell(Text(members[index].paid == 'True' ? 'yes' : 'no')),
                DataCell(Text(members[index].penality.toString())),
              ],
              color: MaterialStateColor.resolveWith((states) {
                return index % 2 == 0 ? Colors.white : Color(0xff079073);
              }),
            ),
          ),
        );
      },
    );
  }
}
