import 'package:flutter_demo/module/custom_paint/pinter/circle_painter.dart';
import 'package:flutter_demo/module/custom_paint/shape_widget.dart';
import 'package:flutter_demo/module/custom_paint/whiteboard_selector_panel_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Created by fanjiajia02 on 2023/4/21
/// Desc: 白板工具栏面板组件

class WhiteBoardControlPanelWidget extends StatefulWidget {

  const WhiteBoardControlPanelWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WhiteBoardControlPanelState();
}

class _WhiteBoardControlPanelState extends State<WhiteBoardControlPanelWidget> {
  late WhiteBoardSelectorPanelViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel =
        Provider.of<WhiteBoardSelectorPanelViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(5.0), right: Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Selector<WhiteBoardSelectorPanelViewModel, bool>(
            selector: (_, viewModel) => viewModel.showColorSelector,
            builder: (context, show, _) {
              return Offstage(
                offstage: !show, // offstage为true的时候不渲染
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          child: Container(
                            width: 26,
                            height: 26,
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.only(left: 15, right: 7),
                        ),
                        // 分割线
                        Padding(
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFB8BFCC),
                                borderRadius: BorderRadius.circular(1.0)),
                            width: 1,
                            height: 16,
                          ),
                          padding: EdgeInsets.only(right: 7),
                        ),
                        // 颜色选择器
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                                itemCount: 20,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ShapeWidget(CirclePainter(
                                      Colors.redAccent, 1,
                                      fill: true));
                                }),
                          ),
                        ),
                      ],
                    ),
                    // 分割线
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      height: 0.5,
                      width: double.infinity,
                      color: const Color(0xFFB8BFCC),
                    )
                  ],
                ),
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 40,
                            height: 46,
                            child: Text("${index + 1}"),
                          );
                        }),
                  )),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () => _viewModel.showOrHideColorSelector(!_viewModel.showColorSelector),
                child: Text("change")),)
        ],
      ),
    );
  }
}
