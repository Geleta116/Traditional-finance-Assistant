import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/Input.dart';
import '../../utilities/block_button.dart';

class CreateEdirScreen extends StatefulWidget {
  const CreateEdirScreen({super.key});

  @override
  State<CreateEdirScreen> createState() => _CreateEdirScreenState();
}

class _CreateEdirScreenState extends State<CreateEdirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Create Edir'),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20.0),
          child:Center(
            child:Column(
              children: [
                SizedBox(height:10.0),
                Text('Create new Edir', 
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  
                ),),
                SizedBox(height: 50.0,),
                
                SizedBox(
                  height:40.0,
                  width: 300.0,
                  child: InputFields(placeholder: 'Edir Name', controller: null, textInputType: TextInputType.text,)),
                SizedBox(height:10.0,),
                
                 SizedBox(
                  height:40.0,
                  width: 300.0,
                  child: InputFields(placeholder: 'amount', controller: null, textInputType: TextInputType.number,)),
                SizedBox(height:10.0,),
                SizedBox(
                  height:40.0,
                  width: 300.0,
                  child: InputFields(placeholder: 'duration', controller: null, textInputType: TextInputType.number,)),
                SizedBox(height:10.0,),
                SizedBox(
                  height:40.0,
                  width: 300.0,
                  child: InputFields(placeholder: 'countdown', controller: null, textInputType: TextInputType.number,)),
                SizedBox(height:40.0,),

                BlockButton(text: 'Create', onPressed: (){},),
              ]) ,)
        )
      ),
      
      );
  }
}