import 'package:flutter/material.dart';

class CustomModel with ChangeNotifier {

  String name = "张三";

  void setName(String na) {
    name = na;
    notifyListeners();
  }

}