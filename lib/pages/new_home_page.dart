import 'package:counter_flutter_demo/entity/route_data.dart';
import 'package:flutter/material.dart';

/// 一个入口页面，展示一个列表，提供所有测试页面的入口
class NewHomePage extends StatelessWidget {

  static const String routeName = "NewHomePage";

  const NewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //下划线widget预定义以供复用。
    Widget divider1 = const Divider(color: Colors.blue,);
    Widget divider2 = const Divider(color: Colors.green);
    return Scaffold(
      appBar: AppBar(title: const Text("路由首页")),
      body: ListView.separated(
          itemCount: RouteData.routes.length,
          separatorBuilder: (BuildContext context, index) {
            return index % 2 == 0 ? divider1 : divider2;
          },
          // 设定的是ListView整体的padding
          itemBuilder: (BuildContext context, int index) {
            RouteData item = RouteData.routes[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(item.route),
              child: ListTile(title: Text(item.title)),
            );
          }),
    );
  }
}
