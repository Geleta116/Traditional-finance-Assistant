import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:traditional_financial_asistant/application/edir/edir_bloc.dart';
import 'package:traditional_financial_asistant/application/edir/edir_state.dart';
import 'package:traditional_financial_asistant/application/edir/edit_event.dart';
import 'package:traditional_financial_asistant/domain/edir/Edir.dart';
import 'package:traditional_financial_asistant/domain/edir/models/Edir.dart';

import '../../utilities/curve_button.dart';

// class Edir {
//   String name;
//   int amount;
//   int duration;
//   int countdown;
//   bool paid;

//   Edir({
//     required this.paid,
//     required this.name,
//     required this.amount,
//     required this.duration,
//     required this.countdown,
//   });
// }

// List<Edir> edirs = [
//   Edir(name: 'edir1', amount: 1000, duration: 3, countdown: 2, paid: false),
//   Edir(name: 'edir2', amount: 2000, duration: 4, countdown: 3, paid: true),
// ];

List<EdirModel> edirs = [];

class EdirLandingPage extends StatefulWidget {
  const EdirLandingPage({super.key});

  @override
  State<EdirLandingPage> createState() => _EdirLandingPageState();
}

class _EdirLandingPageState extends State<EdirLandingPage> {
  void initState() {
    super.initState();
    List<EdirModel> edirs = [];
    final EdirEvent event = EdirLoad();
    BlocProvider.of<EdirBloc>(context)
        .add(event); // Initialize your BLoC instance
    // Emit the desired event
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edir'),
        ),
        body: BlocConsumer<EdirBloc, EdirState>(listener: (context, state) {
          // List<EdirModel> edirs = [];
          if (state is EdirOperationSuccess) {
            // print(state.edirs.name);
            // setState(() {
            //   edirs.addAll(state.edirs);
            // });
          }
        }, builder: (context, state) {
          if (state is EdirOperationSuccess) {
            for (var edir in state.edirs) {
              if (!edirs.contains(edir)) {
                edirs.add(edir);
                
              }
            }
            return Container(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Become a member of an Edir or create one',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CurveButton(
                          text: 'join Edir',
                          onPressed: () => {context.goNamed('joinEdir')},
                          color: Color(0xff6D968F),
                        ),
                        CurveButton(
                          text: 'create Edir',
                          onPressed: () => {context.goNamed('createEdir')},
                          color: Color(0xff6D968F),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Flexible(
                      child: EdirList(
                        edirs: edirs,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(children: [
                  Text(
                    'Start Your Edir Today',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'join a group and start your edir',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CurveButton(
                        text: 'join Edir',
                        onPressed: () {
                          context.goNamed('joinEdir');
                        },
                        color: Color(0xff6D968F),
                      ),
                      CurveButton(
                        text: 'create Edir',
                        onPressed: () {
                          context.goNamed('createEdir');
                        },
                        color: Color(0xff6D968F),
                      ),
                    ],
                  )
                ])));
          }
          ;
        }));
  }
}

class EdirList extends StatefulWidget {
  List<EdirModel> edirs;
  EdirList({super.key, required this.edirs});

  @override
  State<EdirList> createState() => _EdirListState();
}

class _EdirListState extends State<EdirList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: edirs.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print('tapped $index');
          },
          child: Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xff94B297),
              border: Border.all(
                color: Color(0xff94B297),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Text(
                widget.edirs[index].name as String,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
              EdirListTextDetail(
                  boldText: 'amount', normalText: edirs[index].amount),
              EdirListTextDetail(
                  boldText: 'Duration',
                  normalText: widget.edirs[index].duration),
              EdirListTextDetail(
                  boldText: 'Start Date',
                  normalText: widget.edirs[index].countdown),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: true
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.start,
                children: [
                  CurveButton(
                    text: 'leave group',
                    onPressed: () {
                      showConfirmationDialog(context);
                    },
                    color: Colors.redAccent,
                  ),
                  Visibility(
                      visible: true, // edirs[index].paid,
                      child: CurveButton(
                        text: 'pay',
                        onPressed: () => {
                          showModal(context, edirs[index].amount),
                        },
                        color: Colors.indigoAccent,
                      )),
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}

void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to Leave?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Leave'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class EdirListTextDetail extends StatelessWidget {
  String boldText;
  String normalText;
  EdirListTextDetail(
      {super.key, required this.boldText, required this.normalText});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 16.0,
        ),
        children: [
          TextSpan(
            text: boldText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ': $normalText',
          ),
        ],
      ),
    );
  }
}

String ToDuration(int duration) {
  if (duration == 1) {
    return 'daily';
  } else if (duration == 7) {
    return 'weekly';
  } else if (duration == 30) {
    return 'monthly';
  } else {
    return 'every $duration days';
  }
}

String calculateStartDate(int numberOfDays) {
  DateTime now = DateTime.now();
  DateTime startDate = now.add(Duration(days: numberOfDays));

  // Format the start date as a day
  final formatter = DateFormat('MMMM d, yyyy');
  String formattedStartDate = formatter.format(startDate);

  return formattedStartDate;
}

void showModal(BuildContext context, amount) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(40.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pay for this month',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'You are about to pay $amount birr for this month. Are you sure you want to proceed?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                  child: Text('Pay'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
