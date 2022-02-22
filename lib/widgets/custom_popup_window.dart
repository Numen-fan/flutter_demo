import 'dart:core';
import 'dart:ui';

import 'package:counter_flutter_demo/popup_window/triangle_painter.dart';
import 'package:flutter/material.dart';

/// 自定义气泡window
/// 通过[Overlay] + [OverlayEntry]实现，这种方式使得一个[OverlayEntry]居于所有widget之上
/// 这种方式有个特点，BuildContext中没有Navigator，因此无法监听页面返回事件，需要在依附页面响应位置调用[OverlayEntry.remove]消除。
/// 【other】: Flutter中还可以使用[PopupRoute]方式实现气泡，以Route的方式实现，可以监听返回事件，但多用于气泡内有相关操作的场景。

/// 气泡位于目标组件的位置，目前仅提供上下方位。
enum PopAlignment {
  top, down
}

class CustomPopupWindow {

  static const String logTAG = "CustomPopupWindow：";

  BuildContext context;

  PopAlignment alignment; // 在目标组件的方位

  Widget child; // 气泡内容

  double height; // 气泡高度

  double width; // 气泡宽度

  /// 箭头偏移量，默认箭头在气泡[child]居中，通过该变量控制向左向右偏移，负值向左，正值向右
  /// 注意，箭头相对目标锚点区域[targetWidgetRect]始终是居中的《，其本质是移动气泡位置，实现相对偏移
  double? arrowOffset = 0;

  late Offset _position; // 气泡左上角的位置，以屏幕左上角为原点

  Rect? targetWidgetRect; // 目标widget所在的rect

  double? arrowWidth; // 箭头默认宽度

  double? arrowHeight; // 箭头默认高度

  Color backgroundColor; // 背景颜色

  Color? arrowColor; // 箭头颜色，默认和backgroundColor相同

  Size? _screenSize; // 屏幕宽高

  OverlayEntry? _entry;

  CustomPopupWindow({Key? key,
    required this.context,
    required this.alignment,
    required this.child,
    required this.height,
    required this.width,
    required this.backgroundColor,
    this.arrowOffset,
    this.arrowColor,
    this.arrowHeight,
    this.arrowWidth}) {
    arrowHeight ??= 6;
    arrowWidth ??= 10;
    arrowColor ??= backgroundColor;
    arrowOffset ??= 0;
  }

  /// 展示气泡
  /// [targetRect] 目标widget所在区域
  /// [targetGlobalKey] 目标widget的[GlobalKey]
  OverlayEntry? show({Rect? targetRect, GlobalKey? targetGlobalKey}) {
    assert(targetRect != null || targetGlobalKey != null);

    targetWidgetRect = targetRect ?? CustomPopupWindow.getWidgetGlobalRect(targetGlobalKey!);
    if(targetWidgetRect == null) {
      return null;
    }

    _screenSize = MediaQuery.of(context).size;

    calculatePosition(context);

    _entry = OverlayEntry(builder: (context) {
      return buildPopupWindLayout(_position);
    });

    Overlay.of(context)!.insert(_entry!);
    return _entry;
  }

  /// 计算气泡在屏幕中的位置
  void calculatePosition(BuildContext context) {
    // arrowOffset 箭头向左为负值，气泡整体右移动
    double dx = targetWidgetRect!.left + targetWidgetRect!.width / 2 - width / 2 - arrowOffset!;
    // 确定x轴位置
    if(dx < 10) { // 保持10的安全间距
      dx = 10;
    }
    if(dx + width > _screenSize!.width) {
      dx = _screenSize!.width - width - 10;
    }

    // 确定y轴坐标
    // todo y轴忽略了上下的安全距离，因为用户强制设置up和down，暂不考虑
    double dy;
    if(alignment == PopAlignment.top) {
      dy = targetWidgetRect!.top - height - arrowHeight!;
    } else {
      dy = targetWidgetRect!.bottom + arrowHeight!;
    }
    _position = Offset(dx, dy);

    debugPrint(logTAG + "dx = $dx , dy = $dy");

  }

  /// 获取某个组件在屏幕中的区域
  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  void dismiss() {
    _entry?.remove();
    _entry = null;
  }

  LayoutBuilder buildPopupWindLayout(Offset position) {
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => dismiss(),
          onVerticalDragStart: (DragStartDetails details) => dismiss(),
          onHorizontalDragStart: (DragStartDetails details) => dismiss(),
          child: Stack(
            children: [
              // 三角
              Positioned(
                  left: targetWidgetRect!.left + targetWidgetRect!.width / 2 - arrowWidth! / 2,
                  top: alignment == PopAlignment.top ? targetWidgetRect!.top - arrowHeight! : targetWidgetRect!.bottom,
                  child: CustomPaint(
                    size: Size(arrowWidth!, arrowHeight!),
                    painter: TrianglePainter(
                      isDown: alignment == PopAlignment.top, color: arrowColor!),
                ),
              ),
              Positioned(
                  left: position.dx,
                  top: position.dy,
                  child: child)
            ],
          ),
        ),
      );
    });
  }
}