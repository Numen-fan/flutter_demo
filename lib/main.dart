import 'package:counter_flutter_demo/entity/route_data.dart';
import 'package:counter_flutter_demo/pages/form_test_route.dart';
import 'package:counter_flutter_demo/pages/new_home_page.dart';
import 'package:counter_flutter_demo/pages/new_route_page.dart';
import 'package:counter_flutter_demo/pages/home_page.dart';
import 'package:counter_flutter_demo/pages/scroll_controller_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget表示没有状态的组件
class MyApp extends StatelessWidget {
  const MyApp({Key? appKey}) : super(key: appKey); // 注意这里是可选命名参数的调用

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // 并不会展示在页面上，类似Android的name标签
      initialRoute: "/", // 决定app的初始路由, 指定了该属性，则不能赋值 home 字段，否则会异常
      // showPerformanceOverlay: true, // 打开性能监控页面
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 注册路由表
      routes: <String, WidgetBuilder>{
        "/": (context) => const NewHomePage(), // 首页路由
        RouteData.formTestPage: (context) => const FormTestPage(),
        RouteData.oldHomePage: (context) => const MyHomePage(title: ""),
        RouteData.scrollControllerPage: (context) => const ScrollControllerTestPage(),
      }, // 命名路由

      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute(builder: (context) {
      //     String routeName = settings.name ?? ""; // 这里设计不合理啊
      //     // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
      //     // 引导用户登录；其它情况则正常打开路由
      //     // 通过命名路由打开页面
      //     return const NewRoute();
      //   });
      // },

      // home: const MyHomePage(title: 'Flutter Demo Home Page'), // home表示主页
      // home: const Counter(),
    );
  }
}






