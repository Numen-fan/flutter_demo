import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String message,
      {Toast toastLength = Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xA5000000),
        textColor: textColor,
        fontSize: 13.0);
  }

  static void showToast(String message,
      {Toast toastLength = Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0}) {
    Fluttertoast.showToast(
        msg: message,
        //"最多输入3000个字",
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
