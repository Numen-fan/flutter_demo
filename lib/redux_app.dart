import 'package:counter_flutter_demo/redux/redux_page_one.dart';
import 'package:counter_flutter_demo/redux/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReduxApp extends StatelessWidget {
  ReduxApp({Key? key}) : super(key: key);

  final store = Store<CounterState>(reducer,
      initialState: const CounterState.initState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "Redux App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ReduxPageOne(),
      ),
    );
  }
}
