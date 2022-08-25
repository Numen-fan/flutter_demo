import 'package:counter_flutter_demo/entity/route_data.dart';
import 'package:counter_flutter_demo/pages/bottom_navigator_page.dart';
import 'package:counter_flutter_demo/pages/bubble_page.dart';
import 'package:counter_flutter_demo/pages/http_request_page.dart';
import 'package:counter_flutter_demo/pages/dialog_page.dart';
import 'package:counter_flutter_demo/pages/tv_demo.dart';
import 'package:counter_flutter_demo/provider/cart_provider_page.dart';
import 'package:counter_flutter_demo/pages/form_test_route.dart';
import 'package:counter_flutter_demo/pages/new_home_page.dart';
import 'package:counter_flutter_demo/pages/new_route_page.dart';
import 'package:counter_flutter_demo/pages/home_page.dart';
import 'package:counter_flutter_demo/pages/scroll_controller_page.dart';
import 'package:counter_flutter_demo/provider_app.dart';
import 'package:counter_flutter_demo/provider_new/counter_provider_model.dart';
import 'package:counter_flutter_demo/provider_new/provider_selector_page.dart';
import 'package:counter_flutter_demo/redux/counter_state.dart';
import 'package:counter_flutter_demo/redux_app.dart';
import 'package:counter_flutter_demo/scoped_model_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'generated/l10n.dart';

@pragma('vm:entry-point')
void main() {
  /// normal
  runApp(MyApp());

  /// Scoped model
  // runApp(const ScopedModelApp());

  /// redux
  // runApp(ReduxApp());

  /// provider
  final CounterProviderModel counterModel = CounterProviderModel();
  int textSize = 48;
  // runApp(Provider<int>.value(
  //   // 将textSize提供给子孙节点使用, 泛型可省略，建议保留
  //   value: textSize,
  //   child: ChangeNotifierProvider.value(
  //     // 不仅能够提供数据供子孙节点使用，还可以在数据改变的时候通知所有听众刷新。
  //     value: counterModel,
  //     child: ProviderApp(),
  //   ),
  // ));

  /// provider——>使用[MultiProvider]，MultiProvider内部自动转为上述嵌套形式
  // runApp(MultiProvider(
  //   providers: [
  //     Provider<int>.value(value: textSize),
  //     ChangeNotifierProvider.value(value: counterModel),
  //   ],
  //   child: ProviderApp(),
  // ));
}

// StatelessWidget表示没有状态的组件
class MyApp extends StatelessWidget {
  MyApp({Key? appKey}) : super(key: appKey); // 注意这里是可选命名参数的调用

  var channel = const BasicMessageChannel("com.basic.message.channel", StandardMessageCodec());

  Future<Object?> _handleNativeMessage(Object? message) async {
    print(message);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    channel.setMessageHandler(_handleNativeMessage);

    channel.send("你好，我是flutter");

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', "CN")
      ],
      title: 'Flutter Demo', // 并不会展示在页面上，类似Android的name标签
      initialRoute: "/", // 决定app的初始路由, 指定了该属性，则不能赋值 home 字段，否则会异常
      // showPerformanceOverlay: true, // 打开性能监控页面
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 注册路由表
      // routes: <String, WidgetBuilder>{
      //   "/": (context) => const NewHomePage(), // 首页路由
      //   FormTestPage.routeName: (context) => const FormTestPage(),
      //   MyHomePage.routeName: (context) => const MyHomePage(title: ""),
      //   ScrollControllerTestPage.routeName: (context) => const ScrollControllerTestPage(),
      //   CartProviderRoute.routName: (context) => const CartProviderRoute(),
      //   ProviderSelectorPage.routeName: (context) => const ProviderSelectorPage(),
      //   TvDemoPage.routeName: (_) => const TvDemoPage(),
      //   BubblePage.routeName: (_) => const BubblePage(),
      //   HttpRequestPage.routeName: (_) => const HttpRequestPage(),
      //   BottomNavigatorPage.routeName: (_) => const BottomNavigatorPage(),
      //   DialogPage.routeName: (_) => const DialogPage()
      // }, // 命名路由

      // 可以通过在route中携带参数
      onGenerateRoute: (RouteSettings settings) {
        // 应该把case放到前面，返回不同类型的Route
        return MaterialPageRoute(
          builder: (context) {
            String routeName = settings.name ?? ""; // 这里设计不合理啊
            // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
            // 引导用户登录；其它情况则正常打开路由
            // 通过命名路由打开页面
            Widget route = const NewHomePage(); // 默认主页
            switch(routeName) {
              case FormTestPage.routeName:
                return const FormTestPage();
              case MyHomePage.routeName:
                return const MyHomePage(title: "");
              case ScrollControllerTestPage.routeName:
                return const ScrollControllerTestPage();
              case CartProviderRoute.routName:
                return const CartProviderRoute();
              case ProviderSelectorPage.routeName:
                return const ProviderSelectorPage();
              case TvDemoPage.routeName:
                return const TvDemoPage();
              case BubblePage.routeName:
                return const BubblePage();
              case HttpRequestPage.routeName:
                return const HttpRequestPage();
              case BottomNavigatorPage.routeName:
                return const BottomNavigatorPage();
              case DialogPage.routeName:
                return const DialogPage();
            }
            return route;
          },
        );
      },
    );
  }
}
