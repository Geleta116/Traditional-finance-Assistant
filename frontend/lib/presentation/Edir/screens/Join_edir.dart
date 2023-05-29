import 'package:flutter/material.dart';
import '../../utilities/block_button.dart';

import '../../utilities/Input.dart';

class JoinEdirScreen extends StatelessWidget {
  const JoinEdirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Join Edir'),
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
                  
                  child: Image.asset('lib/presentation/images/join.png'),
                  height: 185,
                  width: 250,
                ),
                SizedBox(height:30.0,),
                
                SizedBox(
                  width: 300.0,
                  child: InputFields(placeholder: 'Edir Name', controller: null, textInputType: TextInputType.text,)),
                SizedBox(height:15.0,),
                
                 SizedBox(
                  width: 300.0,
                  child: InputFields(placeholder: 'Edir Code', controller: null, textInputType: TextInputType.text,)),
                SizedBox(height:15.0,),

                BlockButton(text: 'Join', onPressed: (){},),
              ]) ,)
        )
      ),
      
      );
  }
}
