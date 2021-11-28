/// 路由数据
class RouteData {

  static const String formTestPage = "form_test_route";
  static const String oldHomePage = "old_home_page";
  static const String scrollControllerPage = "scroll_controller_page";

  final String title;
  final String route;

  const RouteData(this.title, this.route);

  static const List<RouteData> routes = <RouteData>[
    RouteData("表单页面", formTestPage),
    RouteData("旧主页", oldHomePage),
    RouteData("ScrollController", scrollControllerPage),
  ];
}