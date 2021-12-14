import 'package:counter_flutter_demo/pages/form_test_route.dart';
import 'package:counter_flutter_demo/pages/home_page.dart';
import 'package:counter_flutter_demo/pages/scroll_controller_page.dart';
import 'package:counter_flutter_demo/pages/tv_demo.dart';
import 'package:counter_flutter_demo/provider/cart_provider_page.dart';
import 'package:counter_flutter_demo/provider_new/provider_selector_page.dart';

/// 路由数据
class RouteData {

  final String title;
  final String route;

  const RouteData(this.title, this.route);

  static const List<RouteData> routes = <RouteData>[
    RouteData("表单页面", FormTestPage.routeName),
    RouteData("旧主页", MyHomePage.routeName),
    RouteData("ScrollController", ScrollControllerTestPage.routeName),
    RouteData("CartProvider", CartProviderRoute.routName),
    RouteData("Provider selector page", ProviderSelectorPage.routeName),
    RouteData("Tv Demo", TvDemoPage.routeName),
  ];
}
