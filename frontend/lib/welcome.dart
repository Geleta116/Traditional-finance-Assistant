import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/presentation/utilities/block_button.dart';

import '';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    print('welcome');
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                SizedBox(height: 30.0),
                Container(
                  child: Image.asset('images/welcome.png'),
                  height: 185,
                  width: 250,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Manage Your Equb and Edir',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Column(children: [
                  BlockButton(
                      text: 'Equb',
                      onPressed: () {
                        context.goNamed('ekubLanding');
                      }),
                  BlockButton(text: 'Edir',  onPressed: () {
                        context.goNamed('createEdir');
                      }),
                  BlockButton(text: 'My Profile', onPressed: () {}),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
