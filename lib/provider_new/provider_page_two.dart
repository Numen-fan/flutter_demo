import 'package:flutter_demo/provider_new/counter_provider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderPageTwo extends StatelessWidget {
  ProviderPageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page two"),
      ),
      body: Consumer2<CounterProviderModel, int>(
        builder: (context, counter, textSize, _) {
          return Center(
            child: Text(
              "Value：${counter.value}",
              style: TextStyle(fontSize: textSize.toDouble()),
            ),
          );
        },
      ),
      floatingActionButton: Consumer<CounterProviderModel>(
        builder: (context, counter, child) {
          return FloatingActionButton(
            onPressed: () {
              counter.increment();
            },
            child: child,
          );
        },
        // child是不依赖model部分，不会重建，Q：如果有多个child怎么办呢？？？
        child: const Icon(Icons.add),
      ),
    );
  }
}
