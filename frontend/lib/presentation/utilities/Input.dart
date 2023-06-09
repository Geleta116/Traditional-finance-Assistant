import 'package:flutter/material.dart';


class InputFields extends StatelessWidget {
  final String? placeholder;
  final TextEditingController? controller;
  TextInputType textInputType;
  InputFields({super.key, required this.placeholder,  required this.controller, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller, 
      decoration: InputDecoration(
        hintText: placeholder,
        border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, // Set the border color here
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
      ));
  }
}