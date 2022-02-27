import 'package:counter_flutter_demo/pages/bottom_navigator_page.dart';
import 'package:counter_flutter_demo/pages/bubble_page.dart';
import 'package:counter_flutter_demo/pages/dialog_page.dart';
import 'package:counter_flutter_demo/pages/form_test_route.dart';
import 'package:counter_flutter_demo/pages/home_page.dart';
import 'package:counter_flutter_demo/pages/http_request_page.dart';
import 'package:counter_flutter_demo/pages/scroll_controller_page.dart';
import 'package:counter_flutter_demo/pages/tv_demo.dart';
import 'package:counter_flutter_demo/provider/cart_provider_page.dart';
import 'package:counter_flutter_demo/provider_new/provider_selector_page.dart';

/// 路由数据, 供首页页面选择跳转使用
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
    RouteData("Bubble Demo", BubblePage.routeName),
    RouteData("HttpClient page", HttpRequestPage.routeName),
    RouteData("Bottom navigator page", BottomNavigatorPage.routeName),
    RouteData("Dialog Demo", DialogPage.routeName)
  ];
}
