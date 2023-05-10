import 'package:flutter_demo/module/custom_paint/widget/white_board_painter_selector_widget.dart';
import 'package:flutter_demo/module/custom_paint/widget/white_board_top_bar_widget.dart';
import 'package:flutter_demo/module/custom_paint/view_model/white_board_selector_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Created by fanjiajia02 on 2023/4/19
/// Desc: 白板demo页面
/// <a href=https://ku.baidu-int.com/knowledge/HFVrC7hq1Q/pKzJfZczuc/veCp6c2hyo/yhxg_tWGeunMJL>文档</a>

class WhiteBoardDemoPage extends StatelessWidget {

  static const routeName = "WhiteBoardDemoPage";

  const WhiteBoardDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(title: Text("写写画画"),),
      body: ChangeNotifierProvider<WhiteBoardSelectorViewModel>(
        create: (_) => WhiteBoardSelectorViewModel(),
        child: Column(
          children: [
            const WhiteBoardTopBarWidget(),
            Expanded(child: Container()),
            const WhiteBoardPainterSelectorWidget()
          ],
        ),
      )
    );
  }

}