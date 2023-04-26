import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 画正方形

class SquarePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  final bool fill; // 是否填充
  bool gradient;
  List<Color>? gradientColors;

  SquarePainter(this.color, this.strokeWidth, {this.fill = false, this.gradient = false, this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var rect = Rect.fromCenter(
        center: Offset(width / 2, width / 2), width: width - strokeWidth / 2, height: width - strokeWidth / 2);

    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..shader = gradient ? ui.Gradient.linear(const Offset(0,0), Offset(size.width, size.height), gradientColors!): null
      ..strokeJoin = StrokeJoin.round;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


}