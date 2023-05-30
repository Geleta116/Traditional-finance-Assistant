import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


import 'package:traditional_financial_asistant/domain/ekub/models/Ekub.dart';
import 'package:traditional_financial_asistant/application/ekub/blocs.dart';
import 'package:traditional_financial_asistant/presentation/utilities/block_button.dart';

import '../../utilities/Input.dart';

class CreateEqubScreen extends StatelessWidget {
  TextEditingController? ekubName = TextEditingController();
  TextEditingController? amount = TextEditingController();
  TextEditingController? duration = TextEditingController();
  TextEditingController? countdown = TextEditingController();
  TextEditingController? description = TextEditingController();
  TextEditingController? minMembers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EkubBloc, EkubState>(
        bloc: BlocProvider.of<EkubBloc>(context),
        listener: (context, state) {
          // print(state);
          if (state is EkubOperationSuccess) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('created Ekub succesfully'),
                              content: Text('Created Ekub successfully'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    
                                    context.goNamed('ekubLanding'); // Close the dialog
                                  },
                                  child: Text('Go to ekub landing'),
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
              title: Text('Create Equb'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(children: [
                        SizedBox(height: 10.0),
                        Text(
                          'Create new Equb',
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
                                placeholder: 'Equb Name',
                                controller: ekubName, textInputType: TextInputType.text)),
                        SizedBox(
                          height: 10.0,
                        ),

                        SizedBox(
                            height: 40.0,
                            width: 300.0,
                            child: InputFields(
                                placeholder: 'amount', controller: amount, textInputType: TextInputType.text)),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            height: 40.0,
                            width: 300.0,
                            child: InputFields(
                                placeholder: 'duration', controller: duration, textInputType: TextInputType.text,)),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            height: 40.0,
                            width: 300.0,
                            child: InputFields(
                                placeholder: 'countdown',
                                controller: countdown,textInputType: TextInputType.text )),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            width: 300.0,
                            child: TextField(
                                controller: description,
                                maxLines:
                                    null, // or specify the maximum number of lines desired
                                decoration: InputDecoration(
                                  labelText: 'description',
                                  border:
                                      OutlineInputBorder(), // Optional: to add a border around the text area
                                ))),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 40.0,
                          width: 300.0,
                          child: TextField(
                            controller: minMembers,
                            decoration: InputDecoration(
                                labelText: 'minMembers',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .white, // Set the border color here
                                  ),
                                  borderRadius: BorderRadius.circular(100.0),
                                )),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                          ),
                        ),
                        // Other properties and configurations for the input field

                        SizedBox(
                          height: 40.0,
                        ),

                        BlockButton(
                          text: 'Create',
                          onPressed: () {
                            EkubModel ekub = EkubModel(
                                description: description!.text,
                                name: ekubName!.text,
                                amount: amount!.text,
                                minMembers: minMembers!.text,
                                duration: duration!.text,
                                countdown: countdown!.text);
                                
                            final EkubEvent event = EkubCreate(ekub);
                            BlocProvider.of<EkubBloc>(context).add(event);
                          },
                        ),
                      ]),
                    ))),
          );
        });
  }
}
