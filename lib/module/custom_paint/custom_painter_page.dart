import 'package:flutter_demo/module/custom_paint/white_board_control_panel_widget.dart';
import 'package:flutter_demo/module/custom_paint/white_board_top_bar_widget.dart';
import 'package:flutter_demo/module/custom_paint/whiteboard_selector_panel_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Created by fanjiajia02 on 2023/4/19
/// Desc:

class CustomPainterPage extends StatelessWidget {

  static const routeName = "CustomPainterPage";

  const CustomPainterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(title: Text("写写画画"),),
      body: ChangeNotifierProvider<WhiteBoardSelectorPanelViewModel>(
        create: (_) => WhiteBoardSelectorPanelViewModel(),
        child: Column(
          children: [
            const WhiteBoardTopBarWidget(),
            Expanded(child: Container()),
            const WhiteBoardControlPanelWidget()
          ],
        ),
      )
    );
  }

}