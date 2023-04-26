import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 画斜线
class LinePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  bool gradient;
  List<Color>? gradientColors;

  LinePainter(this.color, this.strokeWidth, {this.gradient = false, this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;

    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..shader = gradient ? ui.Gradient.linear(Offset(size.width, size.height), const Offset(0,0), gradientColors!): null
      ..isAntiAlias = true;

    RRect rect = RRect.fromLTRBR(0, width / 2 - strokeWidth / 2, width, width / 2 + strokeWidth / 2,
        const Radius.circular(1));

    canvas.drawRRect(rect, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}