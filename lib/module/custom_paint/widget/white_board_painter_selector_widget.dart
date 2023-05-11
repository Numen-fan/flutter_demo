import 'dart:math';

import 'package:flutter_demo/module/custom_paint/entity/white_board_define.dart';
import 'package:flutter_demo/module/custom_paint/pinter/white_board_arrow_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/white_board_circle_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/white_board_color_selector_printer.dart';
import 'package:flutter_demo/module/custom_paint/pinter/white_board_hexagon_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/white_board_line_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/white_board_square_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/white_board_triangle_painter.dart';
import 'package:flutter_demo/module/custom_paint/widget/white_board_shape_widget.dart';
import 'package:flutter_demo/module/custom_paint/widget/white_board_painter_szie_decoration.dart';
import 'package:flutter_demo/module/custom_paint/view_model/white_board_selector_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/util/image_loader2.dart';
import 'package:flutter_demo/widgets/click_state_image_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

/// Created by fanjiajia02 on 2023/4/21
/// Desc: 白板画笔选择组件

class WhiteBoardPainterSelectorWidget extends StatefulWidget {

  const WhiteBoardPainterSelectorWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WhiteBoardControlPanelState();
}

class _WhiteBoardControlPanelState extends State<WhiteBoardPainterSelectorWidget>
  with WhiteBoardModelListener {
  late WhiteBoardSelectorViewModel _viewModel;

  // 画笔宽度选择器上默认颜色和选中颜色
  static const defaultSizeColor = Color(0xFF626A80);
  static const selectSizeColor = Color(0xFF3377FF);

  final ScrollController _colorScrollController = ScrollController();
  final ScrollController _painterScrollController = ScrollController();

  bool landscape = false;

  @override
  void initState() {
    super.initState();
    _viewModel =
        Provider.of<WhiteBoardSelectorViewModel>(context, listen: false);
    _viewModel.setListener(this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:AlignmentDirectional.bottomCenter,
      children: [
        // 背景
        Container(
          height: 130,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0x80000000)]
              )
          ),
        ),
        // 内容前景
        _getContentWidget()
      ],
    );
  }

  Widget _getContentWidget() {
     return OrientationBuilder(
        builder: (context, orientation) {
          // builder回传的orientation不准
          landscape = MediaQuery.of(context).orientation == Orientation.landscape;
          double width  = !landscape ? double.infinity : 510.0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 画笔宽度选择器
              _buildPainterSizeSelector(),
              // 底部选择面板
              Container(
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // 颜色选择器
                    _buildColorSelector(),
                    // 画笔工具选择器
                    _buildPainterTypeSelector(),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }

  /// 构建上方的颜色选择器
  Widget _buildColorSelector() {
    return Selector<WhiteBoardSelectorViewModel, bool>(
      selector: (_, viewModel) => viewModel.showColorSelector,
      builder: (context, show, _) {
        return Offstage(
          offstage: !show, // offstage为true的时候不渲染
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    child: ClickStateImageWidget(
                      type: Type.url,
                      normalImgUrl: getImagePath("icon_white_board_size"),
                      activeImgUrl: getImagePath("icon_white_board_size_selected"),
                      onClick: () => _viewModel.showOrHideSizeSelector(!_viewModel.showSizeSelector),
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 7),
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
                    padding:const EdgeInsets.only(right: 3.0),
                  ),
                  // 颜色选择器
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: ListView.builder(
                          controller: _colorScrollController,
                          itemCount: _viewModel.painterColors.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: landscape ? null : const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _viewModel.setCurSelectColor(index);
                                if(index + 2 < _viewModel.painterColors.length) {
                                  onPainterColorChanged(index);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Selector<WhiteBoardSelectorViewModel, bool>(
                                  selector: (context, model) => model.painterColors.values.elementAt(index),
                                  builder: (context, selected, _) {
                                    return WhiteBoardShapeWidget(
                                      WhiteBoardColorSelectorPrinter(
                                          _viewModel.painterColors.keys.elementAt(index),
                                          selected: selected),
                                      width: 32,
                                      height: 32,
                                      key: ObjectKey("$index$selected"), // 【关键】
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
              // 分割线
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 0.5,
                color: const Color(0xFFB8BFCC),
              )
            ],
          ),
        );
      },
    );
  }

  /// 构建底部画笔选择器
  Widget _buildPainterTypeSelector() {
    return SizedBox(
        height: 70,
        child: ListView.builder(
          itemCount: _viewModel.painterTypes.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: landscape ? null : const BouncingScrollPhysics(),
          controller: _painterScrollController,
          itemBuilder: (context, index) {
            var painterType = _viewModel.painterTypes.keys.elementAt(index);
            return Selector<WhiteBoardSelectorViewModel, bool>(
              selector: (context, model) => model.painterTypes.values.elementAt(index),
              builder: (context, selected, _) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _viewModel.setCurSelectPainterType(index);
                    // 避免尾部弹性动画太大
                    if(index + 2 >= _viewModel.painterTypes.length) {
                      return;
                    }
                    double scrollOffset = 10.0;
                    if (index < 2) {
                      scrollOffset = 0;
                    }
                    _painterScrollController.animateTo(
                        scrollOffset * (index + 1),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildPainterType(painterType, selected),
                  ),
                );
              },
            );
          },
        ));
  }

  Widget _buildPainterType(PainterType type, bool selected) {
    Widget painterTypeWidget = Container();
     List<Color> colors = const [Color(0xFF8D97B2), Color(0xFF666F8C)];
    if(selected) {
      colors = const [Color(0xFF54CAFF), Color(0xFF3377FF)];
    }
    switch (type) {
      case PainterType.select:
        painterTypeWidget = _buildImagePainterType("icon_white_board_painter_select", "选择", selected);
        break;
      case PainterType.pen:
        painterTypeWidget = _buildImagePainterType("icon_white_board_painter_pen", "画笔", selected);
        break;
      case PainterType.highlight:
        painterTypeWidget = _buildImagePainterType("icon_white_board_painter_highlighter", "荧光笔", selected);
        break;
      case PainterType.eraser:
        painterTypeWidget = _buildImagePainterType("icon_white_board_painter_eraser", "橡皮擦", selected);
        break;
      case PainterType.arrow:
        painterTypeWidget = _buildCustomPainterType(WhiteBoardArrowPainter(
            const Color(0xFF8D97B2), 3, gradient: true, gradientColors: colors),
            "箭头", selected, trans: true);
        break;
      case PainterType.square:
        painterTypeWidget = _buildCustomPainterType(WhiteBoardSquarePainter(
            const Color(0xFF8D97B2), 3, gradient: true, gradientColors: colors),
            "方形", selected);
        break;
      case PainterType.line:
        painterTypeWidget = _buildCustomPainterType(WhiteBoardLinePainter(
            const Color(0xFF8D97B2), 3, gradient: true, gradientColors: colors),
            "直线", selected, trans: true);
        break;
      case PainterType.circle:
        painterTypeWidget = _buildCustomPainterType(WhiteBoardCirclePainter(
            const Color(0xFF8D97B2), 3, gradient: true, gradientColors: colors),
            "圆形", selected);
        break;
      case PainterType.triangle:
        painterTypeWidget = _buildCustomPainterType(WhiteBoardTrianglePainter(
            const Color(0xFF8D97B2), 3, gradient: true, gradientColors: colors),
            "三角形", selected);
        break;
      case PainterType.hexagon:
        painterTypeWidget = _buildCustomPainterType(WhiteBoardHexagonPainter(
            const Color(0xFF8D97B2), 3, gradient: true, gradientColors: colors),
            "六边形", selected);
        break;
      default:
        debugPrint("default了");
        break;
    }
    return Container(
        alignment: Alignment.center,
        width: 40,
        height: 60,
        child: painterTypeWidget);
  }
  
  /// 图片资源的画笔工具项
  Widget _buildImagePainterType(String imgName, String desc, bool selected) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 3),
            child: ImageLoader(getImagePath(imgName + (selected ? "_selected" : "")), width: 26, height: 26,)),
        Text(
          desc,
          // overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 10,
              color: selected ? const Color(0xFF3377FF) : const Color(0xFF11141A)),
        )
      ],
    );
  }

  /// 自定义图形的画笔工具项
  Widget _buildCustomPainterType(CustomPainter painter, String desc, bool selected, {bool trans = false}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 3),
          width: 26,
          height: 26,
          alignment: Alignment.center,
          child: Transform.rotate(
              angle: trans ? -pi / 4 : 0,
              child: WhiteBoardShapeWidget(painter, width: 21, height: 21)),
        ),
        Text(
          desc,
          // overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 10,
              color: selected ? const Color(0xFF3377FF) : const Color(0xFF11141A)),
        )
      ],
    );
  }

  /// 画笔宽度选择器
  Widget _buildPainterSizeSelector() {
    return Selector<WhiteBoardSelectorViewModel, bool>(
      selector: (context, model) => model.showSizeSelector,
      builder: (context, show, _) {
        var painterType = _viewModel.curPinterType;
        var curPainterSize = _viewModel.getPainterSize(painterType); // 该画笔当前选中的尺寸
        var allSize = _viewModel.getAllPainterSize(painterType); // 该画笔的所有尺寸
        return Offstage(
          offstage: !show, // 为true时child隐藏
          child: Container(
            margin: const EdgeInsets.only(left: 8, bottom: 7),
            decoration: WhiteBoardPainterSizeDecoration(), height: 36,
            child: ListView.builder(
              itemCount: allSize.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _viewModel.setCurPainterSize(allSize[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Center(
                      child: _getPainterSizeWidget(painterType, allSize[index],
                          allSize[index] == curPainterSize),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String getImagePath(String imgName) {
    return "images/white_board/$imgName.svg";
  }

  Widget _getPainterSizeWidget(PainterType painterType, PainterSize painterSize, bool selected) {
    Widget painterSizeWidget = Container();
    switch(painterType) {
      case PainterType.pen:
      case PainterType.highlight:
      painterSizeWidget = _getPainterSizeForPenWidget(painterSize, selected);
        break;
      case PainterType.arrow:
        painterSizeWidget = _getPainterSizeForArrowWidget(painterSize, selected);
        break;
      case PainterType.line:
        painterSizeWidget = _getPainterSizeForLineWidget(painterSize, selected);
        break;
      case PainterType.square:
        painterSizeWidget = _getPainterSizeForSquareWidget(painterSize, selected);
        break;
      case PainterType.hexagon:
        painterSizeWidget = _getPainterSizeForHexagonWidget(painterSize, selected);
        break;
      case PainterType.triangle:
        painterSizeWidget = _getPainterSizeForTriangleWidget(painterSize, selected);
        break;
      case PainterType.circle:
        painterSizeWidget = _getPainterSizeForCircleWidget(painterSize, selected);
        break;
      default:
        break;
    }
    return painterSizeWidget;
  }

  /// 获取画笔和荧光笔的画笔尺寸
  Widget _getPainterSizeForPenWidget(PainterSize painterSize, bool selected) {
    var size = _painterSizeCast(painterSize);
    var iconPath = getImagePath("icon_white_board_line_size_$size");
    return SvgPicture.asset(iconPath, width: 28, height: 28, color: selected ? selectSizeColor : null);
  }

  /// 以下方法重复代码，可以考虑优化。
  Widget _getPainterSizeForLineWidget(PainterSize painterSize, bool selected) {
    var size = _painterSizeCast(painterSize);
    return Transform.rotate(
        key: ObjectKey("$painterSize$selected"),
        angle: -pi / 4,
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          child: WhiteBoardShapeWidget(
              WhiteBoardLinePainter(selected ? selectSizeColor : defaultSizeColor, size.toDouble())),
        ));
  }

  Widget _getPainterSizeForArrowWidget(PainterSize painterSize, bool selected) {
    var size = _painterSizeCast(painterSize);
    return Transform.rotate(
      key: ObjectKey("$painterSize$selected"), //【关键】
        angle: -pi / 4,
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          child: WhiteBoardShapeWidget(
              WhiteBoardArrowPainter(selected ? selectSizeColor : defaultSizeColor, size.toDouble())),
        ));
  }

  Widget _getPainterSizeForSquareWidget(PainterSize painterSize, bool selected) {
    if(painterSize == PainterSize.translucency) {
      var iconPath = getImagePath("icon_white_board_square_size" + (selected ? "_selected" : ""));
      return SvgPicture.asset(iconPath, width: 28, height: 28);
    } else if (painterSize == PainterSize.fill) {
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardSquarePainter(
            selected ? selectSizeColor : defaultSizeColor, 1.0,
            fill: true),key: ObjectKey("$painterSize$selected")),
      );
    } else {
      var size = _painterSizeCast(painterSize);
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardSquarePainter(
            selected ? selectSizeColor : defaultSizeColor, size.toDouble()), key: ObjectKey("$painterSize$selected"),),
      );
    }
  }

  Widget _getPainterSizeForHexagonWidget(PainterSize painterSize, bool selected) {
    if(painterSize == PainterSize.translucency) {
      var iconPath = getImagePath("icon_white_board_hexagon_size" + (selected ? "_selected" : ""));
      return SvgPicture.asset(iconPath, width: 28, height: 28);
    } else if (painterSize == PainterSize.fill) {
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardHexagonPainter(
            selected ? selectSizeColor : defaultSizeColor, 1.0,
            fill: true), key: ObjectKey("$painterSize$selected")),
      );
    } else {
      var size = _painterSizeCast(painterSize);
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardHexagonPainter(
            selected ? selectSizeColor : defaultSizeColor, size.toDouble()), key: ObjectKey("$painterSize$selected")),
      );
    }
  }

  Widget _getPainterSizeForTriangleWidget(PainterSize painterSize, bool selected) {
    if(painterSize == PainterSize.translucency) {
      var iconPath = getImagePath("icon_white_board_triangle_size" + (selected ? "_selected" : ""));
      return SvgPicture.asset(iconPath, width: 28, height: 28);
    } else if (painterSize == PainterSize.fill) {
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardTrianglePainter(
            selected ? selectSizeColor : defaultSizeColor, 1.0,
            fill: true), key: ObjectKey("$painterSize$selected")),
      );
    } else {
      var size = _painterSizeCast(painterSize);
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardTrianglePainter(
            selected ? selectSizeColor : defaultSizeColor, size.toDouble()), key: ObjectKey("$painterSize$selected")),
      );
    }
  }

  Widget _getPainterSizeForCircleWidget(PainterSize painterSize, bool selected) {
    if(painterSize == PainterSize.translucency) {
      var iconPath = getImagePath("icon_white_board_circle_size" + (selected ? "_selected" : ""));
      return SvgPicture.asset(iconPath, width: 28, height: 28);
    } else if (painterSize == PainterSize.fill) {
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardCirclePainter(
            selected ? selectSizeColor : defaultSizeColor, 1.0,
            fill: true), key: ObjectKey("$painterSize$selected"),),
      );
    } else {
      var size = _painterSizeCast(painterSize);
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: WhiteBoardShapeWidget(WhiteBoardCirclePainter(
            selected ? selectSizeColor : defaultSizeColor, size.toDouble()), key: ObjectKey("$painterSize$selected"),),
      );
    }
  }

  int _painterSizeCast(PainterSize painterSize) {
    switch(painterSize) {
      case PainterSize.width1:
        return 1;
      case PainterSize.width2:
        return 2;
      case PainterSize.width3:
        return 3;
      case PainterSize.width4:
        return 4;
      case PainterSize.width5:
        return 5;
      default:
        break;
    }
    return 1;
  }

  @override
  void dispose() {
    super.dispose();
    _colorScrollController.dispose();
    _painterScrollController.dispose();
    _viewModel.setListener(null);
  }

  @override
  onPainterColorChanged(int index) {
    double scrollOffset = 10.0;
    if (index < 2) {
      scrollOffset = 0;
    }
    _colorScrollController.animateTo(scrollOffset * (index + 1),
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
