import 'package:counter_flutter_demo/redux/redux_page_two.dart';
import 'package:counter_flutter_demo/redux/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReduxPageOne extends StatelessWidget {
  const ReduxPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Redux Page One"),),
      body: Center(
        child: StoreConnector<CounterState, int>(
          converter: (store) => store.state.count,
          builder: (context, count) {
            return Text(
              count.toString(),
              style: const TextStyle(fontSize: 48),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ReduxPageTwo())),
        child: const Icon(Icons.forward),
      ),
    );
  }
}
