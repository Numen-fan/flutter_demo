import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/21
/// Desc: 颜色选择器

class WhiteBoardColorSelectorPrinter extends CustomPainter {
  final Color color;
  final bool selected;

  WhiteBoardColorSelectorPrinter(this.color, {this.selected = false});

  @override
  void paint(Canvas canvas, Size size) {
    var innerRadius = 12.0;
    var outerRadius = 15.0;
    var width = size.width;
    var center = Offset(width / 2, width / 2);

    // 先画内部圆
    canvas.drawCircle(
        center,
        innerRadius,
        Paint()
          ..color = color
          ..isAntiAlias = true
          ..style = PaintingStyle.fill);

    if (selected) {
      // 画外圆
      canvas.drawCircle(
          center,
          outerRadius,
          Paint()
            ..color = const Color(0xFF3377FF)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
