import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/21
/// Desc: 颜色选择器

class ColorSelectorPrinter extends CustomPainter {

  final Color color;
  final bool selected;

  ColorSelectorPrinter(this.color, {this.selected = false});


  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}