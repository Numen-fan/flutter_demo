import 'package:counter_flutter_demo/module/theme/theme_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Created by fanjiajia02 on 2023/3/28
/// Desc: 暗黑模式

class ThemePage extends StatefulWidget {
  static const routeName = "ThemePage";

  const ThemePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThemePageState();
  }
}

class ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("主题切换"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("当前主题模式为${context.read<ThemeViewModel>().themeMode}"),
            Switch(
                value: Theme.of(context).brightness == Brightness.light,
                onChanged: (value) {
                  setState(() {
                    context.read<ThemeViewModel>().setThemeMode(value ? ThemeMode.light : ThemeMode.dark);
                  });
                }),
          ],
        )
      ),
    );
  }
}
