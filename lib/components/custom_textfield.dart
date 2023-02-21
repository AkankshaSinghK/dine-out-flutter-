import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
 //const CustomTextField({super.key});
 final TextEditingController? controller;
 final String? labText;
 final TextInputType? keyboardType;
CustomTextField({this.controller,this.keyboardType,this.labText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:keyboardType ,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}