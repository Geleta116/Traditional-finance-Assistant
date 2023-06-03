import 'package:flutter/material.dart';

import '../../utilities/block_button.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          key:Key('welcome'),
          'Traditional Financial Assistant',
          style: TextStyle(
            fontSize: 22.0,
          ),
          ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
         
          child: Center(
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.center,
                
              children: [
                SizedBox(height:30.0),
                
                Container(
                  
                  child: Image.asset('lib/presentation/images/welcome.png'),
                  height: 185,
                  width: 250,
                ),
                SizedBox(height:30.0,),
                
                Column(
                  children: 
                [
                  Text('Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text('Manage Your Equb and Edir',
                style:  TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.black45,
                  ),),
            
                ],),
                
               SizedBox(height:50.0),
                Column(
            
                children:[
                  BlockButton(text: 'Equb', onPressed: (){}),
                  BlockButton(text: 'Edir', onPressed: (){}),
                  BlockButton(text: 'My Profile', onPressed: (){}),
               
                ]
            
                )
                
            
              ],
            
            ),
          ),
        ),
      ),


    );
  }
}