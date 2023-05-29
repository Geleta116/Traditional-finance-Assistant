import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../utilities/curve_button.dart';

import '../utilities/curve_button.dart';
class Equb{
  String name;
  int amount;
  int duration;
  int countdown;
  String description;
  int minMembers; 
  bool paid;

  Equb({
    required this.paid,
    required this.name,
    required this.amount,
    required this.duration,
    required this.countdown,
    required this.description,
    required this.minMembers,
  });


}

List<Equb> equbs = 
[Equb(name: 'equb1',amount: 1000,duration: 3,countdown: 2,description: 'equb1 description',minMembers: 5, paid:false),
Equb(name: 'equb2',amount: 2000,duration: 4,countdown: 3,description: 'equb2 description',minMembers: 5, paid:true),
];
class EqubLandingPage extends StatelessWidget {
  const EqubLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equb'),
        
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
       
       
        child:Center(
          child: Column(
            children: [
              Text(
                'Start Your Equb Today',
                style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400
        
                ),
              ),
              Text(
                'join a group and start your equb',
                style: TextStyle(
                fontSize: 16.0,
                )),
                SizedBox(height:30.0),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  CurveButton(text: 'join Equb', onPressed: () => {}, color:Color(0xff6D968F) ,),
                  CurveButton(text: 'create Equb' , onPressed: () => {}, color: Color(0xff6D968F),),
      
                ],),
                SizedBox(height:30.0),
      
                Flexible(
                  child: EqubList(equbs: equbs,),
                ),
             
      
      
            ],
          ),
        ),
      
        ));
  }
}

class EqubList extends StatefulWidget {
  List<Equb> equbs;
  EqubList({super.key, required this.equbs});

  @override
  State<EqubList> createState() => _EqubListState();
}

class _EqubListState extends State<EqubList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                  itemCount: equbs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){print('tapped $index');},
                      child: Container(
                    
                        margin: EdgeInsets.only(top:10.0, bottom: 10.0),
                        padding: EdgeInsets.all(10.0),
              
                        decoration: BoxDecoration(
                          color: Color(0xff94B297),
                          border: Border.all(
                            color: Color(0xff94B297),
                            
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                       
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                         
                          Center(child: Text(
                            widget.equbs[index].name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            )),
                          EqubListTextDetail(boldText: 'amount', normalText: NumberFormat.currency(
                            symbol:'ETB',
                          ).format(equbs[index].amount)),
                          EqubListTextDetail(boldText: 'Duration', normalText: ToDuration(widget.equbs[index].duration)),
                          EqubListTextDetail(boldText: 'Description', normalText: '${widget.equbs[index].description}'),
                          EqubListTextDetail(boldText: 'Start Date', normalText: calculateStartDate(widget.equbs[index].countdown)),
                          EqubListTextDetail(boldText: 'minMembers', normalText: '${widget.equbs[index].minMembers.toString()}'),
                          Center(
                            child: Visibility(
                              visible: equbs[index].paid,

                              child: CurveButton(text: 'proceed payement', onPressed:() => {showModal(context,equbs[index].amount )},color: Colors.indigoAccent,)))
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
  EqubListTextDetail({super.key, required this.boldText, required this.normalText});

  @override
  Widget build(BuildContext context) {
    return  Text.rich(
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
String ToDuration(int duration){
  if(duration == 1){
    return 'daily';
  }
  else if(duration == 7){
    return 'weekly';
  }
  else if(duration == 30){
    return 'monthly';
  }
  else{
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
