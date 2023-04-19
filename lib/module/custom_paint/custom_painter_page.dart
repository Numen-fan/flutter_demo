import 'package:counter_flutter_demo/module/custom_paint/hexagon_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/4/19
/// Desc:

class CustomPainterPage extends StatelessWidget {

  static const routeName = "CustomPainterPage";

  const CustomPainterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("写写画画"),),
      body: Center(
        child: CustomPaint(
          size: const Size(23, 20),
          painter: HexagonPainter(),
        ),
      ),
    );
  }

}