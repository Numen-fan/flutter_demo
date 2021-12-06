import 'package:counter_flutter_demo/entity/cart_item.dart';
import 'package:counter_flutter_demo/entity/cart_model.dart';
import 'package:counter_flutter_demo/provider/change_notifier_provider.dart';
import 'package:counter_flutter_demo/widgets/consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 采用Provider的购物车页面
class CartProviderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartProviderRouteState();
}

class _CartProviderRouteState extends State<CartProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("跨组件状态管理（Provider）"),
      ),
      body: Center(
          child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(
          builder: (context) {
            print("Builder 1"); // 点击按钮，这里不会执行，因此根Widget不会重新构建
            return Column(
              children: <Widget>[
                // 使用方法1
                // 这个builder中依赖了ChangeNotifierProvider，所以数据发生变化时就会进行重建
                // Builder(
                //   builder: (context) {
                //     print("Builder 2");
                //     var cart = ChangeNotifierProvider.of<CartModel>(context);
                //     return Text("Total:${cart.totalPrice}");
                //   },
                // ),
                // 使用方法2
                Consumer<CartModel>(
                  builder: (context, cart) => Text("Total:${cart!.totalPrice}"),
                ),

                Builder(builder: (context) {
                  print("Builder 3"); // 因为依赖了ChangeNotifierProvider,所以也会重建
                  return ElevatedButton(
                      onPressed: () {
                        ChangeNotifierProvider.of<CartModel>(context, listen: false)
                            .add(Item(20.0, 1));
                      },
                      child: const Text("Add"));
                }),
              ],
            );
          },
        ),
      )),
    );
  }
}
