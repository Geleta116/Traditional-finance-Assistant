import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/application/join/join_bloc.dart';
import 'package:traditional_financial_asistant/application/join/join_event.dart';
import 'package:traditional_financial_asistant/application/join/join_state.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/join.dart';
import 'package:traditional_financial_asistant/presentation/utilities/Input.dart';
import 'package:traditional_financial_asistant/presentation/utilities/block_button.dart';


class JoinEqubScreen extends StatelessWidget {
  // const JoinEqubScreen({super.key});

  TextEditingController? ekubName = TextEditingController();
  TextEditingController? ekubCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinBloc, JoinState>(
        bloc: BlocProvider.of<JoinBloc>(context),
        listener: (context, state) {
          // print(state);
          if (state is JoinOperationSuccess) {
            context.goNamed("EkubLanding");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Join Equb'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(children: [
                        SizedBox(height: 30.0),
                        SizedBox(height: 30.0),
                        Container(
                          child: Image.asset('images/joinEqub.png'),
                          height: 185,
                          width: 250,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                            width: 300.0,
                            child: InputFields(
                              placeholder: 'Equb Name',
                              controller: ekubName,
                              textInputType: TextInputType.text,
                            )),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                            width: 300.0,
                            child: InputFields(
                              placeholder: 'Equb Code',
                              controller: ekubCode,
                              textInputType: TextInputType.text,
                            )),
                        SizedBox(
                          height: 15.0,
                        ),
                        BlockButton(
                          text: 'Join',
                          onPressed: () {
                            JoinModel ekubs = JoinModel(
                                name: ekubName!.text, code: ekubCode!.text);

                            final JoinEvent event = JoinRequest(ekubs);

                            BlocProvider.of<JoinBloc>(context).add(event);
                          },
                        ),
                      ]),
                    ))),
          );
        });
  }
}
