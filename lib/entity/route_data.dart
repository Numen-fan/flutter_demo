import 'package:counter_flutter_demo/listview/custom_list_view_page.dart';
import 'package:counter_flutter_demo/module/StudyDemo/study_demo_main.dart';
import 'package:counter_flutter_demo/module/custom_paint/custom_painter_page.dart';
import 'package:counter_flutter_demo/module/grouplist/member_list.dart';
import 'package:counter_flutter_demo/module/theme/theme_page.dart';
import 'package:counter_flutter_demo/pages/animation_page.dart';
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
import 'package:flutter/cupertino.dart';

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
    RouteData("CustomListView", CustomListViewPage.routeName),
    RouteData("Tv Demo", TvDemoPage.routeName),
    RouteData("Theme", ThemePage.routeName),
    RouteData("Animation", AnimationPage.routeName),
    RouteData("CustomPaint", CustomPainterPage.routeName),
    RouteData("Bubble Demo", BubblePage.routeName),
    RouteData("HttpClient page", HttpRequestPage.routeName),
    RouteData("Bottom navigator page", BottomNavigatorPage.routeName),
    RouteData("MemberList", MemberListPage.route),
    RouteData("Provider", StudyDemoMainPage.route),
    RouteData("Dialog Demo", DialogPage.routeName),
  ];
}
