
import 'package:flutter/material.dart';

/// 定义一个通用的InheritedProvider类，
/// 用于保存共享数据，继承[InheritedWidget]（这里的widget并不能简单的理解为一个视图控件，可以理解为一种数据模型）
/// child是一个视图控件
class InheritedProvider<T> extends InheritedWidget {

  InheritedProvider({required this.data, required Widget child}) : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // 在此简单返回true，表示每次更新都会调用依赖其的子孙节点的didChangeDependencies
    return true;
  }

}
