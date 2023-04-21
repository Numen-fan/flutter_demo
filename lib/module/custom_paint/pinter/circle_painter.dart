import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 画圆

class CirclePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  final bool fill; // 是否填充
  bool gradient;
  List<Color>? gradientColors;

  CirclePainter(this.color, this.strokeWidth, {this.fill = false, this.gradient = false, this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    var radius = (size.width - strokeWidth) / 2;
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..shader = gradient ? ui.Gradient.linear(const Offset(0,0), Offset(size.width, size.height), gradientColors!): null
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


}