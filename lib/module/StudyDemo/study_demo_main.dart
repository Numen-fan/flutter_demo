import 'dart:math';

import 'package:flutter_demo/module/StudyDemo/custom_model.dart';
import 'package:flutter_demo/module/StudyDemo/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyDemoMainPage extends StatefulWidget {

  static const route = "StudyDemoMainPage";

  const StudyDemoMainPage({Key? key}) : super(key: key);

  @override
  _StudyDemoMainPageState createState() => _StudyDemoMainPageState();
}

class _StudyDemoMainPageState extends State<StudyDemoMainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomModel(),
      child: Scaffold(
        appBar: AppBar(title: Text("Provdier"),),
        body: Column(
          children: [
            Selector<CustomModel, String> (
              selector: (context, model) => model.name,
              builder: (context, name, child) {
                return Text(name);
              }
            ),

          Consumer<CustomModel>(
              builder: (context, model, _) => Text(model.name)),

            CustomWidget(),

            Selector<CustomModel, CustomModel> (
                selector: (context, model) => model,
                builder: (context, model, child) {
                  return TextButton(onPressed:()=> model.setName("张三, ${Random().nextInt(100)}" ), child: Text("改变name"));
                }
            ),
          ],
        ),
      ),
    );
  }
}
