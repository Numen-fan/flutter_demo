import 'package:counter_flutter_demo/module/StudyDemo/custom_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CustomWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomModel>(
        builder: (context, model, _) => Text(model.name));
  }
}