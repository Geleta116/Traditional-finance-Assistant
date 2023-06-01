import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/application/user/User_bloc.dart';
import 'package:traditional_financial_asistant/application/user/User_state.dart';

import '../../../application/user/User_event.dart';
import '../../../domain/register/memeber_model.dart';
import '../../utilities/User.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  List<Member> members = []; // Updated variable name

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
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
        } else if (state is MemberOperationSuccess) {
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
            members.length,
            (index) => DataRow(
              cells: [
                DataCell(Text((index + 1).toString())),
                DataCell(Text(members[index].username == null
                    ? ''
                    : members[index].username!)),
                DataCell(Text(members[index].won == 'True' ? 'yes' : 'no')),
                DataCell(Text(
                    members[index].paid == null ? '' : members[index].paid!)),
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
