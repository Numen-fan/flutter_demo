import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 三角形

class TrianglePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  final bool fill; // 是否填充
  bool gradient;
  List<Color>? gradientColors;

  TrianglePainter(this.color, this.strokeWidth, {this.fill = false, this.gradient = false, this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width - strokeWidth / 2;

    var path = Path();
    path.moveTo(width / 2, 0);
    path.lineTo(width, width * cos(pi * 1/ 12));
    path.lineTo(0, width * cos(pi * 1/ 12));
    path.close();

    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..shader = gradient ? ui.Gradient.linear(const Offset(0,0), Offset(size.width, size.height), gradientColors!): null
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}