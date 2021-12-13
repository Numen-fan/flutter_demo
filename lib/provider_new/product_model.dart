import 'package:counter_flutter_demo/entity/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductModel extends ChangeNotifier {
  ProductModel() {
    debugPrint("Create instance of ProductModel");
  }

  final List<Product> _products =
      List.generate(10, (index) => Product("Product $index"));

  bool shouldRebuild = false;

  List<Product> get products => _products;

  int get total => _products.length;

  /// Collect the [index]'s product
  void collect(int index) {
    Product oldProduct = _products[index];
    // update the product
    _products[index] = Product(oldProduct.name, collect: !oldProduct.collect);
    notify(false);
  }

  /// Add new Product to [_products]
  void addProduct() {
    debugPrint("User add new product");
    _products.add(Product("Product $total"));
    notify(true);
  }

  /// Notify the listener
  /// the widget rebuild when [shouldRebuild] is true, otherwise not.
  void notify(bool shouldRebuild) {
    this.shouldRebuild = shouldRebuild;
    notifyListeners();
  }

  @override
  void dispose() {
    debugPrint("ProductModel dispose execute");
    super.dispose();
  }
}
