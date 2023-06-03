import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/application/edir/edir_bloc.dart';
import 'package:traditional_financial_asistant/application/edir/edir_state.dart';
import 'package:traditional_financial_asistant/application/edir/edit_event.dart';
import 'package:traditional_financial_asistant/application/user/User_bloc.dart';
import 'package:traditional_financial_asistant/application/user/User_event.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir.Dto.dart';

import '../../utilities/block_button.dart';
// import '../../Edir presentaion/utilities/block_button.dart';

class EdirCreatorScreen extends StatefulWidget {
  const EdirCreatorScreen({super.key});

  @override
  State<EdirCreatorScreen> createState() => _EdirCreatorScreenState();
}

class _EdirCreatorScreenState extends State<EdirCreatorScreen> {
  @override
  Widget build(BuildContext context) {
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
          title: Text('Edir Name'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      'Edir Name',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Image.asset('lib/presentation/images/peoples.png'),
                      height: 140,
                      width: 200,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'see all Edirtegna and their status ',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    BlocConsumer<EdirBloc, EdirState>(
                        listener: (context, state) {
                          if(state is EdirOperationSuccess){
                            context.goNamed('landing');
                          }
                      // TODO: implement listener
                    }, builder: (context, state) {
                      bool? isVisible = false;
                      if (state is EdirDetailState) {
                        bool? isVisible = state.edir.creator;
                        EdirDto edir = state.edir.toDto();

                        return Column(
                          children: [
                            BlockButton(
                                text: 'Members',
                                onPressed: () {
                                  if (state is EdirDetailState) {
                                    String edirName = state.edir.name.value
                                        .getOrElse(() => '');

                                    BlocProvider.of<UserBloc>(context)
                                        .add(AllEdirMemebers(edirName));
                                    context.goNamed('edirmember');
                                  }
                                  ;
                                }),
                            SizedBox(height: 2),
                            Visibility(
                              visible: isVisible!,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (state is EdirDetailState) {
                                    String edirName = edir.name;
                                    BlocProvider.of<EdirBloc>(context)
                                        .add(EdirDelete(edirName));
                                    context.goNamed('landing');
                                  }
                                },
                                child: Text('Delete'),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: Text("couldn't Load Edir Detail"),
                        );
                      }
                      ;
                    }),
                    
                  ],
                ),
              )),
        ));
  }
}
