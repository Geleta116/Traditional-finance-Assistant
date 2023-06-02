import 'package:flutter/material.dart';


class CurveButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  Color? color;
  final Key? key;

   CurveButton({required this.text, required this.onPressed, this.color, this.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: 140.0,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(text),
                style:ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: color,
                  
                  textStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
            
                ),
            ); ;
  }
}