import 'dart:math';

import 'package:flutter_demo/module/custom_paint/pinter/circle_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/color_selector_printer.dart';
import 'package:flutter_demo/module/custom_paint/pinter/curve_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/hexagon_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/line_painter.dart';
import 'package:flutter_demo/module/custom_paint/pinter/triangle_painter.dart';
import 'package:flutter_demo/module/custom_paint/shape_widget.dart';
import 'package:flutter_demo/module/custom_paint/pinter/square_painter.dart';
import 'package:flutter_demo/module/custom_paint/white_board_control_panel_widget.dart';
import 'package:flutter_demo/module/custom_paint/whiteboard_selector_panel_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pinter/arrow_painter.dart';
/// Created by fanjiajia02 on 2023/4/19
/// Desc:

class CustomPainterPage extends StatelessWidget {

  static const routeName = "CustomPainterPage";

  const CustomPainterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(title: Text("写写画画"),),
      body: ChangeNotifierProvider<WhiteBoardSelectorPanelViewModel>(
        create: (_) => WhiteBoardSelectorPanelViewModel(),
        child: ShapeWidget(ColorSelectorPrinter(Colors.red, selected: true), width: 36, height: 36,),
      )
    );
  }

}

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// ShapeWidget(HexagonPainter(Colors.blueAccent, 1.0, fill: true)),
// ShapeWidget(HexagonPainter(Colors.blueAccent, 1.0)),
// ShapeWidget(HexagonPainter(Colors.blueAccent, 2.0)),
// ShapeWidget(HexagonPainter(Colors.blueAccent, 3.0)),
// ShapeWidget(HexagonPainter(Colors.blueAccent, 4.0)),
// ShapeWidget(HexagonPainter(Colors.blueAccent, 5.0)),
// ],
// ),
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// ShapeWidget(TrianglePainter(Colors.blueAccent, 1.0, fill: true)),
// ShapeWidget(TrianglePainter(Colors.blueAccent, 1.0)),
// ShapeWidget(TrianglePainter(Colors.blueAccent, 2.0)),
// ShapeWidget(TrianglePainter(Colors.blueAccent, 3.0)),
// ShapeWidget(TrianglePainter(Colors.blueAccent, 4.0)),
// ShapeWidget(TrianglePainter(Colors.blueAccent, 5.0)),
// ],
// ),
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// ShapeWidget(CirclePainter(Colors.blueAccent, 1.0, fill: true)),
// ShapeWidget(CirclePainter(Colors.blueAccent, 1.0)),
// ShapeWidget(CirclePainter(Colors.blueAccent, 2.0)),
// ShapeWidget(CirclePainter(Colors.blueAccent, 3.0)),
// ShapeWidget(CirclePainter(Colors.blueAccent, 4.0)),
// ShapeWidget(CirclePainter(Colors.blueAccent, 5.0)),
// ShapeWidget(CirclePainter(Colors.blueAccent, 3.0, gradient: true,
// gradientColors: [Color(0xFF54CAFF), Color((0xFF3377FF))]))
// ],
// ),
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// ShapeWidget(SquarePainter(Colors.blueAccent, 1.0, fill: true)),
// ShapeWidget(SquarePainter(Colors.blueAccent, 1.0)),
// ShapeWidget(SquarePainter(Colors.blueAccent, 2.0)),
// ShapeWidget(SquarePainter(Colors.blueAccent, 3.0)),
// ShapeWidget(SquarePainter(Colors.blueAccent, 4.0)),
// ShapeWidget(SquarePainter(Colors.blueAccent, 5.0)),
// ],
// ),
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Transform.rotate(angle: -pi / 4, child: ShapeWidget(LinePainter(Colors.blueAccent, 1.0))),
// Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 2.0))),
// Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 3.0))),
// Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 4.0))),
// Transform.rotate(angle:-pi/4, child: ShapeWidget(LinePainter(Colors.blueAccent, 5.0))),
// ],
// ),
//
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 1.0))),
// Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 2.0))),
// Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 3.0))),
// Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 4.0))),
// Transform.rotate(angle: -pi / 4, child: ShapeWidget(ArrowPainter(Colors.blueAccent, 5.0))),
// ],
// ),
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// ShapeWidget(CurvePainter(Colors.blueAccent, 1.0)),
// ShapeWidget(CurvePainter(Colors.blueAccent, 2.0)),
// ShapeWidget(CurvePainter(Colors.blueAccent, 3.0)),
// ShapeWidget(CurvePainter(Colors.blueAccent, 4.0)),
// ShapeWidget(CurvePainter(Colors.blueAccent, 5.0)),
// ],
// ),
//
// SizedBox(height: 20,),
// WhiteBoardControlPanelWidget()
// ],
// )