import 'package:flutter/material.dart';

import './shopping_page_content.dart';
import 'package:counter_flutter_demo/entity/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: const Center(
        child: ShoppingList(<Product>[
          Product("IQOO"),
          Product("VIVO"),
          Product("OPPO"),
          Product("Smartsina"),
          Product("iPhone"),
          Product("MacBook Pro"),
          Product("HUAWEI"),
          Product("三星"),
          Product("XIAOMI"),
          Product("Google"),
          Product("Honor"),
          Product("Redmi"),
          Product("realme"),
          Product("红魔"),
          Product("IQOO"),
          Product("VIVO"),
          Product("OPPO"),
          Product("Smartsina"),
          Product("iPhone"),
          Product("MacBook Pro"),
          Product("HUAWEI"),
          Product("三星"),
          Product("XIAOMI"),
          Product("Google"),
          Product("Honor"),
          Product("Redmi"),
          Product("realme"),
          Product("红魔"),
        ]),
      ),
    );
  }
}
