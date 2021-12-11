import 'package:counter_flutter_demo/provider_new/counter_provider_model.dart';
import 'package:counter_flutter_demo/provider_new/provider_page_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderPageOne extends StatelessWidget {
  ProviderPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _counter =
        Provider.of<CounterProviderModel>(context); // 向上获取到CounterProviderModel类型的provider实例
    final _textSize = Provider.of<int>(context).toDouble(); // 向上获取int类型的数据
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Page one",
        ),
      ),
      body: Center(
        child: Text(
          "Value：${_counter.value}",
          style: TextStyle(fontSize: _textSize),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProviderPageTwo()));
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
