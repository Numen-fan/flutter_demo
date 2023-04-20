import 'package:flutter/cupertino.dart';

/// Created by fanjiajia02 on 2023/4/20
/// Desc: 封装各个形状

class ShapeWidget extends StatelessWidget {

  final CustomPainter painter;

  const ShapeWidget(this.painter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(23, 23),
      painter: painter,
    );
  }

}