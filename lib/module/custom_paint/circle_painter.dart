import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 画圆

class CirclePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  final bool fill; // 是否填充

  CirclePainter(this.color, this.strokeWidth, {this.fill = false});

  @override
  void paint(Canvas canvas, Size size) {
    var radius = (size.width - strokeWidth) / 2;
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


}