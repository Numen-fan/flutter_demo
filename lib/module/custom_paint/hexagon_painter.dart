import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/19
/// Desc: 正六边形

class HexagonPainter extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {
    print("paint");
    var paint = Paint()
      ..color = Colors.blueAccent
      ..isAntiAlias = true
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.moveTo(0, 10);
    path.lineTo(5.5, 0);
    path.lineTo(17.5, 0);
    path.lineTo(23, 10);
    path.lineTo(17.5, 20);
    path.lineTo(5.5, 20);
    path.lineTo(0, 10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;



}