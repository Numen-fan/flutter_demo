import 'package:counter_flutter_demo/scopedmodel/counter_model.dart';
import 'package:counter_flutter_demo/scopedmodel/scoped_model_page_two.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelApp extends StatelessWidget {
  const ScopedModelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
        model: CounterModel(),
        child: const MaterialApp(
          home: ScopedModelPageTwo(),
        ));
  }
}
