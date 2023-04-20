import 'dart:math';

import 'package:counter_flutter_demo/module/custom_paint/circle_painter.dart';
import 'package:counter_flutter_demo/module/custom_paint/curve_painter.dart';
import 'package:counter_flutter_demo/module/custom_paint/hexagon_painter.dart';
import 'package:counter_flutter_demo/module/custom_paint/line_painter.dart';
import 'package:counter_flutter_demo/module/custom_paint/shape_widget.dart';
import 'package:counter_flutter_demo/module/custom_paint/square_painter.dart';
import 'package:counter_flutter_demo/module/custom_paint/triangle_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'arrow_painter.dart';

/// Created by fanjiajia02 on 2023/4/19
/// Desc:

class CustomPainterPage extends StatelessWidget {

  static const routeName = "CustomPainterPage";

  const CustomPainterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("写写画画"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShapeWidget(HexagonPainter(Colors.blueAccent, 1.0, fill: true)),
              ShapeWidget(HexagonPainter(Colors.blueAccent, 1.0)),
              ShapeWidget(HexagonPainter(Colors.blueAccent, 2.0)),
              ShapeWidget(HexagonPainter(Colors.blueAccent, 3.0)),
              ShapeWidget(HexagonPainter(Colors.blueAccent, 4.0)),
              ShapeWidget(HexagonPainter(Colors.blueAccent, 5.0)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShapeWidget(TrianglePainter(Colors.blueAccent, 1.0, fill: true)),
              ShapeWidget(TrianglePainter(Colors.blueAccent, 1.0)),
              ShapeWidget(TrianglePainter(Colors.blueAccent, 2.0)),
              ShapeWidget(TrianglePainter(Colors.blueAccent, 3.0)),
              ShapeWidget(TrianglePainter(Colors.blueAccent, 4.0)),
              ShapeWidget(TrianglePainter(Colors.blueAccent, 5.0)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShapeWidget(CirclePainter(Colors.blueAccent, 1.0, fill: true)),
              ShapeWidget(CirclePainter(Colors.blueAccent, 1.0)),
              ShapeWidget(CirclePainter(Colors.blueAccent, 2.0)),
              ShapeWidget(CirclePainter(Colors.blueAccent, 3.0)),
              ShapeWidget(CirclePainter(Colors.blueAccent, 4.0)),
              ShapeWidget(CirclePainter(Colors.blueAccent, 5.0)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShapeWidget(SquarePainter(Colors.blueAccent, 1.0, fill: true)),
              ShapeWidget(SquarePainter(Colors.blueAccent, 1.0)),
              ShapeWidget(SquarePainter(Colors.blueAccent, 2.0)),
              ShapeWidget(SquarePainter(Colors.blueAccent, 3.0)),
              ShapeWidget(SquarePainter(Colors.blueAccent, 4.0)),
              ShapeWidget(SquarePainter(Colors.blueAccent, 5.0)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Transform.rotate(angle: -pi / 4, child: ShapeWidget(LinePainter(Colors.blueAccent, 1.0))),
              Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 2.0))),
              Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 3.0))),
              Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 4.0))),
              Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 5.0))),
            ],
          ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 1.0))),
              Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 2.0))),
              Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 3.0))),
              Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 4.0))),
              Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 5.0))),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShapeWidget(CurvePainter(Colors.blueAccent, 1.0)),
              ShapeWidget(CurvePainter(Colors.blueAccent, 2.0)),
              ShapeWidget(CurvePainter(Colors.blueAccent, 3.0)),
              ShapeWidget(CurvePainter(Colors.blueAccent, 4.0)),
              ShapeWidget(CurvePainter(Colors.blueAccent, 5.0)),
            ],
          ),
        ],
      )
    );
  }

}