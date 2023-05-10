import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/24
/// Desc: 白板画笔宽度选择器气泡样式

class WhiteBoardPainterSizeDecoration extends Decoration {
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
    Rect inRect = Rect.fromLTRB(rect.left + 1, rect.top + 1, rect.right - 1, rect.bottom - 1);
    final Paint paint = Paint()
      ..color = const Color(0xFFB8BFCC)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    RRect innerRect = RRect.fromRectAndRadius(inRect, const Radius.circular(4));
    canvas.drawRRect(outerRect, paint);
    paint.color = Colors.white;
    canvas.drawRRect(innerRect, paint);

    // 画三角
    Path path = Path()
      ..moveTo(rect.left + 10, rect.bottom - 3)
      ..lineTo(rect.left + 15, rect.bottom + 3)
      ..lineTo(rect.left + 20, rect.bottom - 3)
      ..close();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    // 三角描边
    path = Path();
    path.moveTo(rect.left + 10, rect.bottom - 1);
    path.lineTo(rect.left + 15, rect.bottom + 3);
    path.lineTo(rect.left + 20, rect.bottom - 1);

    paint.color = const Color(0xFFB8BFCC);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paint);

  }
}