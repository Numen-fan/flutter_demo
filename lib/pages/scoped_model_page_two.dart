import 'package:counter_flutter_demo/model/counter_model.dart';
import 'package:counter_flutter_demo/pages/scoped_model_page_one.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelPageTwo extends StatelessWidget {
  const ScopedModelPageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Page two"),
        ),
        body: Center(
          child: Text(
            model.count.toString(),
            style: const TextStyle(fontSize: 48),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const ScopedModelPageOne();
            }
          )),
          tooltip: 'forward',
          child: const Icon(Icons.arrow_forward_sharp),
        ),
      );
    });
  }
}
