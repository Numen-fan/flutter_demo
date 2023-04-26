import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 箭头

class ArrowPainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  bool gradient;
  List<Color>? gradientColors;

  ArrowPainter(this.color, this.strokeWidth, {this.gradient = false, this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..shader = gradient ? ui.Gradient.linear(Offset(size.width / 2, 0), Offset(size.width / 2, size.width), gradientColors!): null
      ..style =PaintingStyle.fill;


    // 先画三角形
    var path = Path();
    var arrowWidth = 5 + strokeWidth;
    path.moveTo(width, width / 2);
    path.lineTo(width - arrowWidth * sin(pi / 4), width / 2 - arrowWidth * cos(pi / 4));
    path.lineTo(width - arrowWidth * sin(pi / 4), width / 2 + arrowWidth * cos(pi / 4));
    path.close();


    // 画箭头的下面
    RRect rect = RRect.fromLTRBR(0, width / 2 - strokeWidth / 2, width - arrowWidth * sin(pi / 4) + 1, width / 2 + strokeWidth / 2,
        const Radius.circular(1));

    canvas.drawPath(path, paint);
    canvas.drawRRect(rect, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}