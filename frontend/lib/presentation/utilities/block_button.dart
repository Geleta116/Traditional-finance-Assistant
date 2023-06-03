import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget{
  String text;
  VoidCallback onPressed;
  final Key? key;
  BlockButton({ required this.text, required this.onPressed, this.key});
  Widget build(BuildContext context){
    return SizedBox(
              width: 200.0,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(text),
                style:ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6D968F),
                  
                  textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
            
                ),
            );
  }
}