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
    final Paint paint = Paint()
      ..color = Colors.white;
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(6));
    canvas.drawRRect(rrect, paint);

    final Path path = Path()
      ..moveTo(rect.left + rect.width / 2 - 10, rect.bottom)
      ..lineTo(rect.left + rect.width / 2, rect.bottom + 10)
      ..lineTo(rect.left + rect.width / 2 + 10, rect.bottom)
      ..close();
    paint.color = Colors.white;
    canvas.drawPath(path, paint);
  }
}