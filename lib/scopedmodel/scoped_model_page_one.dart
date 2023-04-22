import 'package:flutter_demo/scopedmodel/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelPageOne extends StatelessWidget {
  const ScopedModelPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Page one"),
            ),
            body: Center(
              child: Text(
                model.count.toString(),
                style: const TextStyle(fontSize: 48),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => model.increment(),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
