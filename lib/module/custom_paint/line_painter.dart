import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 画斜线
class LinePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;

  LinePainter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;

    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    RRect rect = RRect.fromLTRBR(0, width / 2 - strokeWidth / 2, width, width / 2 + strokeWidth / 2,
        const Radius.circular(1));

    canvas.drawRRect(rect, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}