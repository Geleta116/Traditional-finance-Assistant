import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/Input.dart';
import '../utilities/curve_button.dart';


class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account') ,
        centerTitle: true,
        actions: [
           IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showLogoutConfirmationDialog(context);
            },
          ),
         
        ],
        
      ),
      body: SingleChildScrollView(
        child: Container(

          child: Center(
            child: Column(
              children: [

                 Container(
                  
                  child: Image.asset('images/profile.png'),
                  height: 185,
                  width: 250,
                ),
                SizedBox(height:30.0,),
                Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'username',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                'Total Amount Saved',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),

              ),
              Text(
                NumberFormat.currency(symbol: 'ETB').format(1000),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 30.0,),
              CurveButton(
                color:Color(0xff6D968F),
                text: 'Deposit',
                onPressed: (){
                  showDialog(
    context: context, 
    builder: (BuildContext context)  {
      return AlertDialog(
        title: Text('Deposit Amount'),
        content:SingleChildScrollView(
          child: Column(
            
            mainAxisSize: MainAxisSize.min,
            children: [
               Column(
                 
                 children: <Widget>[
                   InputFields(controller: null, placeholder: 'Amount', textInputType: TextInputType.number),
                    SizedBox(height: 20.0,),
                    CurveButton(
                      color:Color(0xff6D968F),
                      text: 'Deposit',
                      onPressed: (){
                        _showDialog(context, 'Deposit Successful');
                      },
                    ),
                 ],
               ),
            ],
          ),
        ) ,
         actions: [
             Align(
            alignment: Alignment.topRight,
            child: TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
      ),
    
          ],
      );
      
    },
    
    
    
    
    );
                },
              ),
              SizedBox(height: 20.0,),              
              ListTile(
                tileColor: Color(0xffBCCED3),
                leading: Icon(Icons.group),
                title: Text('total Equb joined: 5'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){},
              ),
              SizedBox(height: 20.0,),
              ListTile(
                tileColor: Color(0xffBCCED3),
                leading: Icon(Icons.houseboat_rounded),
                title: Text('total Edir joined: 5'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){},
              ),






            ]),
          ),
        ),
      ),
    );
  }

   void _showDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

 void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop(); 
                
              },
            ),
          ],
        );
      },
    );
  }