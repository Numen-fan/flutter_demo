import 'package:flutter/material.dart';

import '../../entity/product.dart';

typedef CartChangedCallback = void Function(Product product, bool inCard);

// 无状态的一个商品item => Widget
class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final CartChangedCallback onCardChanged;

  ShoppingListItem(
      {required this.product,
      required this.inCart,
      required this.onCardChanged})
      : super(key: ObjectKey(product));

  Color _getColor(BuildContext context) {
    return inCart
        ? Colors.black54
        : Theme.of(context).primaryColor; // 注意Theme.of
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) {
      return null;
    }

    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onCardChanged(product, inCart),
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
