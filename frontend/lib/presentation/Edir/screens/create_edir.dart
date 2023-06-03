import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/application/edir/edir_bloc.dart';
import 'package:traditional_financial_asistant/application/edir/edir_state.dart';
import 'package:traditional_financial_asistant/application/edir/edir_bloc.dart';
import 'package:traditional_financial_asistant/application/edir/edir_state.dart';
import 'package:traditional_financial_asistant/application/edir/edit_event.dart';
// import 'package:traditional_financial_asistant/application/edir/edit_event.dart';
import 'package:traditional_financial_asistant/domain/edir/models/Edir.dart';

import '../../utilities/Input.dart';
import '../../utilities/block_button.dart';

// import '../../Edir presentaion/utilities/Input.dart';
// import '../../Edir presentaion/utilities/block_button.dart';

class CreateEdirScreen extends StatefulWidget {
  

  @override
  State<CreateEdirScreen> createState() => _CreateEdirScreenState();
}

class _CreateEdirScreenState extends State<CreateEdirScreen> {

  TextEditingController? edirName = TextEditingController();
  TextEditingController? amount = TextEditingController();
  TextEditingController? duration = TextEditingController();
  TextEditingController? countdown = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EdirBloc, EdirState>(
        bloc: BlocProvider.of<EdirBloc>(context),
        listener: (context, state) {
          if (state is EdirCreateFailure){
            ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Unable to create edir')));
          }
          if (state is EdirCreateSuccess){
             showDialog(
              
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('created Edir succesfully'),
                              content: Text('code: ${state.edirDto.code}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    
                                    context.goNamed('ekublanding'); // Close the dialog
                                  },
                                  child: Text('Go back '),
                                ),
                              ],
                            );
                          },
                        );
                      
                            
          
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  BlocProvider.of<EdirBloc>(context)
                                        .add(EdirLoad());
                  context.goNamed('landing');
                },
              ),
              title: Text('Create Edir'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(children: [
                        SizedBox(height: 10.0),
                        Text(
                          'Create new Edir',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(
                            height: 40.0,
                            width: 300.0,
                            child: InputFields(
                              placeholder: 'Edir Name',
                              controller: edirName,
                              textInputType: TextInputType.text,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            height: 40.0,
                            width: 300.0,
                            child: InputFields(
                              placeholder: 'amount',
                              controller: amount,
                              textInputType: TextInputType.number,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            height: 40.0,
                            width: 300.0,
                            child: InputFields(
                              placeholder: 'duration',
                              controller: duration,
                              textInputType: TextInputType.number,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            height: 40.0,
                            width: 300.0,
                            child: InputFields(
                              placeholder: 'countdown',
                              controller: countdown,
                              textInputType: TextInputType.number,
                            )),
                        SizedBox(
                          height: 40.0,
                        ),
                        BlockButton(
                          text: 'Create',
                          onPressed: () {

                                 EdirModel edir = EdirModel(
                                
                                name: edirName!.text,
                                amount: amount!.text,
                                duration: duration!.text,
                                countdown: countdown!.text);
                           final EdirEvent event = EdirCreate(edir);
                            BlocProvider.of<EdirBloc>(context).add(event);
                          },
                        ),
                      ]),
                    ))),
          );
        });
  }
}
