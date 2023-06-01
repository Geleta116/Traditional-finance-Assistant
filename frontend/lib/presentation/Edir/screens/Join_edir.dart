import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traditional_financial_asistant/application/join/join_event.dart';
import 'package:traditional_financial_asistant/application/join/join_state.dart';
import 'package:traditional_financial_asistant/application/join_edir/join_bloc.dart';
import 'package:traditional_financial_asistant/application/join_edir/join_event.dart';
import 'package:traditional_financial_asistant/application/join_edir/join_state.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/join.dart';
import '../../utilities/block_button.dart';

import '../../utilities/Input.dart';

class JoinEdirScreen extends StatelessWidget {
  // const JoinEdirScreen({super.key});
  TextEditingController? edirName = TextEditingController();
  TextEditingController? edirCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinEdirBloc , JoinEdirState>(
       bloc: BlocProvider.of<JoinEdirBloc>(context),
      listener: (context, state) {
        // TODO: implement listener
        print("succesfully created the edir");
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Join Edir'),
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
                        child: Image.asset('lib/presentation/images/join.png'),
                        height: 185,
                        width: 250,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                          width: 300.0,
                          child: InputFields(
                            placeholder: 'Edir Name',
                            controller: edirName,
                            textInputType: TextInputType.text,
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                          width: 300.0,
                          child: InputFields(
                            placeholder: 'Edir Code',
                            controller: edirCode,
                            textInputType: TextInputType.text,
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      BlockButton(
                        text: 'Join',
                        onPressed: () {
                          JoinModel ekubs = JoinModel(
                                name: edirName!.text, code: edirCode!.text);

                            final JoinEdirEvent event = JoinEdirRequest(ekubs);

                            BlocProvider.of<JoinEdirBloc>(context).add(event);
                        },
                      ),
                    ]),
                  ))),
        );
      },
    );
  }
}
