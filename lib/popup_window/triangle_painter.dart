import 'package:flutter/rendering.dart';

/// 画一个三角形
class TrianglePainter extends CustomPainter {
  bool isDown; // 箭头朝上还是朝下
  Color color;

  TrianglePainter({this.isDown = true, this.color=const Color.fromARGB(0, 0, 0, 0)});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.strokeWidth = 2.0;
    _paint.color = color;
    _paint.style = PaintingStyle.fill;

    Path path = Path();
    if (isDown) {
      path.moveTo(0.0, -1.0);
      path.lineTo(size.width, -1.0);
      path.lineTo(size.width / 2.0, size.height);
    } else {
      path.moveTo(size.width / 2.0, 0.0);
      path.lineTo(0.0, size.height + 1);
      path.lineTo(size.width, size.height + 1);
    }

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
