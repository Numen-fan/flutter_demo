import 'dart:collection';

import 'package:flutter_demo/provider/cart_item.dart';
import 'package:flutter/material.dart';

/// 跨组件共享的model类，继承ChangeNotifier，作为事件发布者
class CartModel extends ChangeNotifier {

  // 用于保存购物车中商品列表
  final List<Item> _items = [];


  // 禁止改变购物车的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 获取购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 向购物车添加item，这是外部唯一改变购物车的方法
  void add(Item item) {
    _items.add(item);
    // 通知订阅者，重新构建InheritedProvider，更新状态
    notifyListeners();
  }

}
