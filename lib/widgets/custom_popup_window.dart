import 'dart:core';
import 'dart:ui';

import 'package:counter_flutter_demo/popup_window/triangle_painter.dart';
import 'package:flutter/material.dart';

enum PopAlignment {
  top, down
}

/// 自定义气泡
class CustomPopupWindow {

  BuildContext context;

  PopAlignment alignment; // 在目标组件的方位

  Widget child; // 气泡内容

  double height; // 气泡高度

  double width; // 气泡宽度

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
    this.arrowColor,
    this.arrowHeight,
    this.arrowWidth}) {
    arrowHeight ??= 6;
    arrowWidth ??= 10;
    arrowColor ??= backgroundColor;
  }

  OverlayEntry? show({Rect? rect, GlobalKey? widgetKey}) {
    assert(rect != null || widgetKey != null);

    targetWidgetRect = rect ?? CustomPopupWindow.getWidgetGlobalRect(widgetKey!);
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

  /// 计算气泡在屏幕的位置
  void calculatePosition(BuildContext context) {
    double dx = targetWidgetRect!.left + targetWidgetRect!.width / 2 - width / 2;
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

    debugPrint("dx = $dx + , dy = $dy");

  }

  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  void dismiss() {
    _entry?.remove();
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