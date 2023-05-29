import 'package:flutter/material.dart';
import '../../utilities/block_button.dart';

class EdirDetailCreatorScreen extends StatefulWidget {
  const EdirDetailCreatorScreen({super.key});

  @override
  State<EdirDetailCreatorScreen> createState() => _EdirDetailCreatorScreenState();
}

class _EdirDetailCreatorScreenState extends State<EdirDetailCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text('Edir Name'),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20.0),
          child:Center(
            child: Column(
              children: [
                SizedBox(height:10.0),
                Text('Edir Name', 
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  
                ),),
                SizedBox(height: 10.0,),
                 Container(
                  
                  child: Image.asset('lib/presentation/images/peoples.png'),
                  height: 140,
                  width: 200,
                ),
                SizedBox(height:10.0),
                Text('see all Edirtegna and their status ', 
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                ),),
                SizedBox(height:10.0),
                BlockButton(text: 'Members', onPressed: (){},),
                SizedBox(height:10.0),
                Text('notify all Edirtegna about recent developments',),
                SizedBox(height:20.0),
                 SizedBox(
                  width: 300.0,
                child: TextField(
                maxLines: null, 
                decoration: InputDecoration(
                  labelText: 'message to all Edirtegna',
                  border: OutlineInputBorder(
                  
                

                  ), 
                ))),
                SizedBox(height:10.0),
                BlockButton(text: 'Notify The Edir', onPressed: (){},),




              ],
            ),
            
        )
      ),
      
     ) );
  }
}