import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/24
/// Desc:

class TooltipDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TooltipPainter();
  }
}

class _TooltipPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    RRect outerRect = RRect.fromRectAndRadius(rect, const Radius.circular(6));
    Rect inRect = Rect.fromLTRB(rect.left + 2, rect.top + 2, rect.right - 2, rect.bottom - 2);
    final Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    RRect innerRect = RRect.fromRectAndRadius(inRect, const Radius.circular(4));
    canvas.drawRRect(outerRect, paint);
    paint.color = Colors.white;
    canvas.drawRRect(innerRect, paint);

    // 画三角
    Path path = Path()
      ..moveTo(rect.left + 10, rect.bottom - 3)
      ..lineTo(rect.left + 15, rect.bottom + 4)
      ..lineTo(rect.left + 20, rect.bottom - 3)
      ..close();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    // 三角描边
    path = Path();
    path.moveTo(rect.left + 10, rect.bottom - 1);
    path.lineTo(rect.left + 15, rect.bottom + 4);
    path.lineTo(rect.left + 20, rect.bottom - 1);

    paint.color = Colors.yellow;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paint);

  }
}