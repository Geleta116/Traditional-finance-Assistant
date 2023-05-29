import 'package:flutter/material.dart';
import '../utilities/block_button.dart';

import '../utilities/Input.dart';

class JoinEqubScreen extends StatelessWidget {
  const JoinEqubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Join Equb'),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20.0),
          child:Center(
            child:Column(
              children: [
                SizedBox(height:30.0),
                 SizedBox(height:30.0),
                
                Container(
                  
                  child: Image.asset('images/joinEqub.png'),
                  height: 185,
                  width: 250,
                ),
                SizedBox(height:30.0,),
                
                SizedBox(
                  width: 300.0,
                  child: InputFields(placeholder: 'Equb Name', controller: null, textInputType: TextInputType.text,)),
                SizedBox(height:15.0,),
                
                 SizedBox(
                  width: 300.0,
                  child: InputFields(placeholder: 'Equb Code', controller: null, textInputType: TextInputType.text,)),
                SizedBox(height:15.0,),

                BlockButton(text: 'Join', onPressed: (){},),
              ]) ,)
        )
      ),
      
      );
  }
}
