import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 画正方形

class SquarePainter extends CustomPainter {

  final Color color;
  final double strokeWidth;
  final bool fill; // 是否填充

  SquarePainter(this.color, this.strokeWidth, {this.fill = false});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width - strokeWidth;
    var rect = Rect.fromCenter(
        center: Offset(width / 2, width / 2), width: width, height: width);

    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


}