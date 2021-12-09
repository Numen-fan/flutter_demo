import 'package:flutter/material.dart';

/// State中所有的属性都应该是只读的
@immutable
class CounterState {
  final int _count;

  int get count => _count;

  const CounterState(this._count);

  const CounterState.initState() : _count = 0;
}

/// 定义操作该State的全部Action
/// 这里只有增加count一个动作
enum Action { increment }

/// reducer会根据传入的参数action生成新的CounterState
CounterState reducer(CounterState oldState, action) {
  // 匹配action
  if (action == Action.increment) {
    return CounterState(oldState.count + 1); // 一个新的state对象
  }
  return oldState;
}
