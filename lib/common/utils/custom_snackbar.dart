import 'package:flutter/material.dart';

class CustomSnackBar {
  static showSnack(BuildContext context, String message,Color backgroundColor, Color color){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message,style: TextStyle(color: color, fontWeight: FontWeight.w700, fontFamily: "Vazir"),),backgroundColor: backgroundColor,));
  }
}