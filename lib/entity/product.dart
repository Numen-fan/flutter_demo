/// 描述一个产品
class Product {
  final bool collect; // 是否收藏
  final String name;

  const Product(this.name, {this.collect = false});
}
