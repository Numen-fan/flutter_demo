import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 封装各个形状

class ShapeWidget extends StatelessWidget {

  final CustomPainter painter;

  final double width;
  final double height;

  const ShapeWidget(this.painter, {Key? key, this.width = 20, this.height = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: painter,
    );
  }
}