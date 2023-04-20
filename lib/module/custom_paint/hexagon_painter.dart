import 'dart:math';

import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/19
/// Desc: 正六边形

class HexagonPainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  final bool fill; // 是否填充

  HexagonPainter(this.color, this.strokeWidth, {this.fill = false});


  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    var radius = (size.width - strokeWidth) / 2; // 将正六边形看做圆的内切，stroke会占据一部分空间
    var path = Path();
    var angle = 2 * pi / 6; // 60度旋转单位

    var centerX = radius;
    var centerY = radius;
    var sideLength = radius; // 六边形边长

    path.moveTo(centerX + sideLength * cos(0), centerY + sideLength * sin(0));

    for (var i = 1; i <= 6; i++) {
      path.lineTo(centerX + sideLength * cos(angle * i),
          centerY + sideLength * sin(angle * i));
    }
    path.close();

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;



}