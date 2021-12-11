import 'package:counter_flutter_demo/provider/inherited_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// 本质上是一个Widget，用于外层包装子树，监控数据改变
/// 这其实是T的事件订阅者，负责更新UI的工作
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {

  ChangeNotifierProvider({Key? key, required this.data, required this.child});

  final T data;
  final Widget child;

  /// 定义一个便捷方法，方便『子树』的widget中获取共享数据
  /// 注意看这里，共享数据仍然在[InheritedProvider]中啊
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget
          as InheritedProvider<T>;
    return provider!.data;
  }

  @override
  State<StatefulWidget> createState() => _ChangeNotifierProviderState<T>();

}

/// 主要作用就是监听到共享状态改变时，重新构建Widget树。
class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {

  // 所以当CartModel中add方法调用之后，会执行此方法
  void update() {
    setState(() => {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当provider更新时，如果新旧数据不"=="，则解绑数据监听，同时添加新的数据监听
    if(widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update); // 注意是oldWidget
      widget.data.addListener(update);
    }
  }

  @override
  void initState() {
    // 给model添加监听器，因为data继承ChangeNotifier
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // 构建provider，这里widget.child始终是同一个，所以build方法不会导致其child重建，
    // 但是如果父级widget发生改变，则其传入的child自然也会重新build
    return InheritedProvider<T>(data: widget.data, child: widget.child);
  }
}