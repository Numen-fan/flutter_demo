import 'package:flutter_demo/redux/counter_state.dart' as counter_state;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReduxPageTwo extends StatelessWidget {
  const ReduxPageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Redux Page Two")),
        body: Center(
          child: StoreConnector<counter_state.CounterState, int>(
            converter: (store) => store.state.count,
            builder: (context, count) {
              return Text(
                count.toString(),
                style: const TextStyle(fontSize: 48),
              );
            },
          ),
        ),
        floatingActionButton: StoreConnector<counter_state.CounterState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(counter_state.Action.increment);
          },
          builder: (context, callback) {
            return FloatingActionButton(
              onPressed: callback,
              child: const Icon(Icons.add),
            );
          },
        ));
  }
}
