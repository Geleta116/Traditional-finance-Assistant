import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utilities/block_button.dart';

class EqubDetailEqubCreatorScreen extends StatelessWidget {
  const EqubDetailEqubCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text('Equb Name'),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20.0),
          child:Center(
            child: Column(
              children: [
                SizedBox(height:10.0),
                Text('Equb Name', 
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  
                ),),
                SizedBox(height: 10.0,),
                 Container(
                  
                  child: Image.asset('images/peoples.png'),
                  height: 140,
                  width: 200,
                ),
                SizedBox(height:10.0),
                Text('see all user in the equb and their status', 
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                ),),
                SizedBox(height:10.0),
                BlockButton(text: 'Members', onPressed: (){},),
                SizedBox(height:10.0),
                Container(
                  
                  child: Image.asset('images/blacklist.png'),
                  height: 140,
                  width: 200,
                ),
                SizedBox(height:10.0),
                Text(
                  'list of people who didn’t pay for this month', 
                  style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                )
                  ),

                  SizedBox(height:10.0),
                BlockButton(text: 'Blacklist', onPressed: (){},),




              ],
            ),
            
        )
      ),
      
     ) );
  }
}