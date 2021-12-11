import 'package:counter_flutter_demo/provider_new/provider_page_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderApp extends StatelessWidget {

  ProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: ProviderPageOne(),
    );
  }
}