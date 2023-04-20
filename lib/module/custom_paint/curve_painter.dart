import 'dart:ui';

import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 绘制曲线
class CurvePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;

  CurvePainter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    var width = 36.0;
    var height = 24.0;
    var path = Path();

    // path.moveTo(0, height); // 起点
    // path.quadraticBezierTo(0, 0, width / 4, 0);
    // path.cubicTo(3 * width / 8, height / 4, 5 * width / 8, 3 * height / 4, width * 3 / 4, height);
    // path.quadraticBezierTo(width, height, width, height / 2);

    List<Offset> list = []
      ..add(Offset(0, height - (6 - strokeWidth)))
      ..add(Offset(width / 4, 0))
      ..add(Offset(3 * width / 4, height))
      ..add(Offset(width, height / 2));

    //返回一个Offset值列表
    final spline = CatmullRomSpline(list);

    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    // canvas.drawPath(path, paint);

    canvas.drawPoints(PointMode.points, spline.generateSamples().map((e) => e.value).toList(), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}