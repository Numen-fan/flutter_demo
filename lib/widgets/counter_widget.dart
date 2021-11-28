
import 'package:flutter/material.dart';

// 定义一个有状态的组件，用于做计数处理，在计数发生改变时，会重新刷新上面两个显示组件
class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      CounterIncrementor(onPressed: _increment),
      CounterDisplay(count: _counter),
    ]);
  }
}

// 无状态的一个显示组件
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count'),
      ],
    );
  }
}


// 无状态的按钮，响应点击事件
class CounterIncrementor extends StatelessWidget {
  const CounterIncrementor({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed; // 传值是_CounterState中的_increment

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Increment'),
    );
  }
}
