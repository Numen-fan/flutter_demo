import 'package:counter_flutter_demo/entity/product.dart';
import 'package:counter_flutter_demo/provider_new/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderSelectorPage extends StatelessWidget {

  static const String routeName = "ProviderSelectorPage";

  const ProviderSelectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 只在这个页面使用provider，如果切换页面，则model的数据不会共享
      create: (context) => ProductModel(), // 懒加载的，在第一次使用的时候才创建
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Provider Selector Page"),
        ),
        body: Selector<ProductModel, List<Product>>(
          shouldRebuild: (preItems, items) { 
            debugPrint("Get change event, should rebuild ${ preItems.length != items.length}");
            return preItems.length != items.length; // 长度不等时，进行列表的刷新
          },
          selector: (context, provider) => provider.products,

          builder: (context, items, _) {
            debugPrint("Rebuild the list");
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Selector<ProductModel, Product>(
                    selector: (context, product) => items[index],
                    builder: (context, product, child) {
                      debugPrint("Rebuild the item $index");
                      return ListTile(
                        title: Text(product.name),
                        trailing: GestureDetector(
                          onTap: () => context.read<ProductModel>().collect(index),
                          child: Icon(
                              product.collect ? Icons.star : Icons.star_border),
                        ),
                      );
                    },
                  );
                });
          },
        ),
        floatingActionButton: Selector<ProductModel, ProductModel>(
          selector: (context, provider) => provider,
          shouldRebuild: (pre, cur) => false,
          builder: (context, provider, child) {
            debugPrint("Rebuild the float button");
            return FloatingActionButton(
              onPressed: () => provider.addProduct(),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
