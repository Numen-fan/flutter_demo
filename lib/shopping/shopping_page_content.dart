import 'dart:developer';

import 'package:flutter/material.dart';

import '../entity/product.dart';
import '../shopping/widget/product_item_widget.dart';

// 页面主元素
class ShoppingList extends StatefulWidget {
  final List<Product> _products;

  const ShoppingList(this._products, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShoppingListState();
}

// 状态, 这里指定的泛型为ShoppingList，表明该状态和ShoppingList组件关联
// 需要说明的是，组件widget可能会被重建，但是state之后创建一次，当新的widget创建后，Flutter的ui框架会动态重新绑定。
class _ShoppingListState extends State<ShoppingList> {
  final Set<Product> _shoppingCart = {};

  // 首次插入到widget树中会调用，对于每一个State对象，Flutter 框架只会调用一次该回调，
  // 所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等
  @override
  void initState() {
    super.initState();
    _shoppingCart.add(const Product("传音"));
    log("状态初始化");
  }

  // 执行热加载会调用
  @override
  void didUpdateWidget(covariant ShoppingList oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("didUpdateWidget");
  }

  // 当 State 对象从树中被移除时，会调用此回调。
  // 如果移除后 没有 重新插入到树中则紧接着会调用dispose()方法。
  @override
  void deactivate() {
    super.deactivate();
    log("deactivate");
  }

  //当 State 对象从树中被永久移除时调用；通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    log("dispose");
  }

  // 每次热加载时会调用，只会在开发调试时使用，每次在热重载之后调用，release模式下并不会调用
  // 所以是否可以使用此回调来判断热重载是否成功呢？
  @override
  void reassemble() {
    super.reassemble();
    log("reassemble");
  }

  // 当State对象的依赖发生变化时会被调用，典型场景是系统locale等发生变化
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log("didChangeDependencies");
  }

  void _handleCartChanged(Product product, bool inCart) {
    // setState在其内部remove和add执行之后
    setState(() {
      if (inCart) {
        // 说明点之前在购物车，因此移除
        _shoppingCart.remove(product); // 移除
      } else {
        _shoppingCart.add(product); // 添加
      }
    });
  }

  // build的执行时机是handleCartChanged中setState执行之后
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      // 注意这里可以直接拿到widget，虽然widget为_products, 但是我们在同一dart文件中，因此是可以访问的
      children: widget._products
          .map(
            (product) => ShoppingListItem(
                // 注意箭头函数，这里不需要有return
                product: product,
                inCart: _shoppingCart.contains(product),
                onCardChanged: _handleCartChanged),
          )
          .toList(),
    );
  }
}
