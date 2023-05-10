import 'package:flutter/material.dart';
import 'package:flutter_demo/module/custom_paint/view_model/white_board_selector_view_model.dart';
import 'package:flutter_demo/util/image_loader2.dart';
import 'package:provider/provider.dart';

/// Created by fanjiajia02 on 2023/4/26
/// Desc: 白板顶部工具条

class WhiteBoardTopBarWidget extends StatefulWidget {
  const WhiteBoardTopBarWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WhiteBoardTopBarState();
}

class WhiteBoardTopBarState extends State<WhiteBoardTopBarWidget> {
  bool landscape = false;

  late WhiteBoardSelectorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<WhiteBoardSelectorViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      // builder回传的orientation不准
      landscape = MediaQuery.of(context).orientation == Orientation.landscape;
      return Container(
        margin: EdgeInsets.only(top: landscape ? MediaQuery.of(context).systemGestureInsets.top + 5 : 55),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _viewModel.quitWhiteBoard(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "退出批注",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Expanded(child: Container()),

            // 撤销
            Selector<WhiteBoardSelectorViewModel, bool>(
              selector: (context, model) => model.undoEnable,
              builder: (context, undoEnable, _) {
                String iconName = "icon_white_board_undo_" + (undoEnable ? "enable" : "disable");
                return GestureDetector(
                  onTap: undoEnable ? _viewModel.undo : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:10),
                    child: ImageLoader(getImagePath(iconName)),
                  ),
                );
              }
            ),

            Selector<WhiteBoardSelectorViewModel, bool>(
                selector: (context, model) => model.redoEnable,
                builder: (context, redoEnable, _) {
                  String iconName = "icon_white_board_redo_" + (redoEnable ? "enable" : "disable");
                  return GestureDetector(
                    onTap: redoEnable ? _viewModel.redo : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:10),
                      child: ImageLoader(getImagePath(iconName)),
                    ),
                  );
                }
            ),

            // 删除
            GestureDetector(
              onTap: ()=>_viewModel.deleteAnnotation(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:10),
                child: ImageLoader(getImagePath("icon_white_board_delete")),
              ),
            ),

            // 保存截图
            Offstage(
              offstage: !_viewModel.supportSave,
              child: GestureDetector(
                onTap: () => _viewModel.saveScreenshot(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:10),
                  child: ImageLoader(getImagePath("icon_white_board_save")),
                ),
              ),
            ),
            const SizedBox(width: 5,)
          ],
        ),
      );
    });
  }

  String getImagePath(String imgName) {
    return "images/white_board/$imgName.svg";
  }
}
