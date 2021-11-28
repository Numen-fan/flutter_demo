import 'package:flutter/material.dart';

import 'home_page.dart';

// 独立的APP
class CartApp extends StatelessWidget {
  const CartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "购物车",
      home: HomePage(),
    );
  }
}
