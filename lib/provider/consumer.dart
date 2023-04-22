import 'package:flutter_demo/provider/change_notifier_provider.dart';
import 'package:flutter/material.dart';

class Consumer<T> extends StatelessWidget {
  const Consumer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// 这里Widget Function整体作为一个声明，即声明函数类型
  /// builder为函数，调用其将返回一个Widget
  final Widget Function(BuildContext context, T? model) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}
