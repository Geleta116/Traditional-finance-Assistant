import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:traditional_financial_asistant/application/ekub/ekub_bloc.dart';
import 'package:traditional_financial_asistant/application/ekub/ekub_event.dart';
import 'package:traditional_financial_asistant/application/ekub/ekub_state.dart';
// import 'package:traditional_finance_assistant__app/application/ekub/blocs.dart';
// import 'package:traditional_finance_assistant__app/domain/ekub/models/Ekub.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/Ekub.dart';
import 'package:traditional_financial_asistant/presentation/utilities/curve_button.dart';

import '../../../application/user/User_bloc.dart';
import '../../../application/user/User_event.dart';
// import '../../application/ekub/ekub_bloc.dart';
// import '../../application/ekub/ekub_state.dart';
// import '../../domain/ekub/Ekub.dart';
// import 'utilities/block_button.dart';

// import 'utilities/curve_button.dart';

// class Equb {
//   String name;
//   int amount;
//   int duration;
//   int countdown;
//   String description;
//   int minMembers;
//   bool paid;

//   Equb({
//     required this.paid,
//     required this.name,
//     required this.amount,
//     required this.duration,
//     required this.countdown,
//     required this.description,
//     required this.minMembers,
//   });
// }

List<EkubModel> equbs = [];

class EqubLandingPage extends StatefulWidget {
  const EqubLandingPage({Key? key}) : super(key: key);

  @override
  State<EqubLandingPage> createState() => _EqubLangingPageState();
}

class _EqubLangingPageState extends State<EqubLandingPage> {
  // List<EkubModel> equbs = [];

  void initState() {
    super.initState();
    equbs = [];
    final EkubEvent event = EkubLoad();
    BlocProvider.of<EkubBloc>(context)
        .add(event); // Initialize your BLoC instance
    // Emit the desired event
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equb'),
      ),
      body: BlocConsumer<EkubBloc, EkubState>(
        bloc: BlocProvider.of<EkubBloc>(context),
        listener: (context, state) {
          if (state is EkubOperationSuccess) {
            setState(() {
              equbs.addAll(state.ekubs);
            });
          }
        },
        builder: (context, state) {
          
          if (state is EkubOperationSuccess) {
            // for (var ekub in state.ekubs) {
            //   if (!equbs.contains(ekub)) {
            //     equbs.add(ekub);
            //   }
            // }

            return Container(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Start Your Equb Today',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'join a group and start your equb',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CurveButton(
                          text: 'join Equb',
                          onPressed: () {
                            context.goNamed('joinEkub');
                          },
                          color: Color(0xff6D968F),
                        ),
                        CurveButton(
                          text: 'create Equb',
                          onPressed: () {
                            context.goNamed('createEkub');
                          },
                          color: Color(0xff6D968F),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Flexible(
                      child: EqubList(
                        equbs: equbs,
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
                    'Start Your Equb Today',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'join a group and start your equb',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CurveButton(
                        text: 'join Equb',
                        onPressed: () {
                          context.goNamed('joinEkub');
                        },
                        color: Color(0xff6D968F),
                      ),
                      CurveButton(
                        text: 'create Equb',
                        onPressed: () {
                          context.goNamed('createEkub');
                        },
                        color: Color(0xff6D968F),
                      ),
                    ],
                  )
                ])));
          }
        },
      ),
    );
  }
}

class EqubList extends StatefulWidget {
  List<EkubModel> equbs;
  EqubList({super.key, required this.equbs});

  State<EqubList> createState() => _EqubListState();
}

class _EqubListState extends State<EqubList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: equbs.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            
            BlocProvider.of<EkubBloc>(context)
                .add(EkubDetail(equbs[index].toEqubEntity()));
            context.goNamed('ekubDetailEqubCreator');
          },
          child: Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            padding: EdgeInsets.all(10.0),
            // height: widget.equbs[index].paid ? 190.0 : 150.0,
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
                widget.equbs[index].name as String,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
              EqubListTextDetail(
                  boldText: 'amount', normalText: equbs[index].amount
                  // NumberFormat.currency(
                  //   symbol: 'ETB',
                  // ).format(equbs[index].amount)),
                  ),
              EqubListTextDetail(
                boldText: 'Duration',
                normalText: widget.equbs[index].duration,
              ),
              EqubListTextDetail(
                  boldText: 'Description',
                  normalText: widget.equbs[index].description),
              EqubListTextDetail(
                  boldText: 'Start Date',
                  normalText: widget.equbs[index].countdown),
              EqubListTextDetail(
                  boldText: 'minMembers',
                  normalText: '${widget.equbs[index].minMembers.toString()}'),
              Center(
                  child: Visibility(
                      visible: equbs[index].canPay as bool,
                      child: CurveButton(
                text: 'proceed payement',
                onPressed: () => {showModal(context, index)},
                color: Colors.indigoAccent,
              )))
            ]),
          ),
        );
      },
    );
  }
}

class EqubListTextDetail extends StatelessWidget {
  String boldText;
  String normalText;
  EqubListTextDetail(
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

void showModal(BuildContext context, index) {
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
                  'You are about to pay for this month. Are you sure you want to proceed?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(makePayement(equbs[index].name as String));
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
