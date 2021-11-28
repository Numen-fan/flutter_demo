import 'package:counter_flutter_demo/entity/cart_item.dart';
import 'package:counter_flutter_demo/entity/cart_model.dart';
import 'package:counter_flutter_demo/provider/change_notifier_provider.dart';
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
      appBar: AppBar(title: const Text("跨组件状态管理（Provider）"),),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    var cart = ChangeNotifierProvider.of<CartModel>(context);
                    return Text("Total:${cart.totalPrice}");
                  },
                ),
                Builder(builder: (context) {
                  print("ElevatedButton build");
                  return ElevatedButton(
                      onPressed: () {
                        ChangeNotifierProvider.of<CartModel>(context)
                            .add(Item(20.0, 1));
                      },
                      child: const Text("Add"));
                }),
              ],
            );
          },),
        )
      ),
    );
  }

}