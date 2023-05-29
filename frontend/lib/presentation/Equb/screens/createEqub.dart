import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilities/Input.dart';
import '../utilities/block_button.dart';

class CreateEqubScreen extends StatefulWidget {
  const CreateEqubScreen({super.key});

  @override
  State<CreateEqubScreen> createState() => _CreateEqubScreenState();
}

class _CreateEqubScreenState extends State<CreateEqubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Create Equb'),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20.0),
          child:Center(
            child:Column(
              children: [
                SizedBox(height:10.0),
                Text('Create new Equb', 
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  
                ),),
                SizedBox(height: 50.0,),
                
                SizedBox(
                  height:40.0,
                  width: 300.0,
                  child: InputFields(placeholder: 'Equb Name', controller: null, textInputType: TextInputType.text,)),
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
                SizedBox(height:10.0,),
                SizedBox(
                  width: 300.0,
                child: TextField(
                maxLines: null, 
                decoration: InputDecoration(
                  labelText: 'description',
                  border: OutlineInputBorder(
                  
                

                  ), 
                ))),
                SizedBox(height:10.0,),
                SizedBox(
                  height:40.0,
                  width:300.0,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'minMembers',
                      border: OutlineInputBorder(

                      borderSide: BorderSide(
                      color: Colors.white, // Set the border color here
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                      )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],),
                ),
  // Other properties and configurations for the input field



                SizedBox(height:40.0,),

                BlockButton(text: 'Create', onPressed: (){},),
              ]) ,)
        )
      ),
      
      );
  }
}