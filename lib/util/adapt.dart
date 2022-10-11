import 'package:flutter/material.dart';

const designWidth = 750;
const designHeight = 1334;

class Adapt {
  static MediaQueryData? _mediaQueryData;
  static double _width = -1;
  static double _height = 0;
  static double _topBarH = 0;
  static double _bottomBarH = 0;
  static double _px = -1;

  static void initialize(BuildContext context) {
    if (_px != -1) {
      return;
    }

    _mediaQueryData = MediaQuery.of(context);
    _width = _mediaQueryData!.size.width;
    _height = _mediaQueryData!.size.height;
    _topBarH = _mediaQueryData!.padding.top;
    _bottomBarH = _mediaQueryData!.padding.bottom;

    if (_width.toInt() == 0 || _height.toInt() == 0) {
      return;
    }

    _px = _width / designWidth * 2;
    // LogUtil.waring("zhulei --- ", "_px222 is ${_width}/${designWidth} * 2");
  }

  static double px(double number) {
    return (_px == -1) ? number : number * _px;
  }

  static onepx() {
    return 1 / _px;
  }

  static screenW() {
    return _width;
  }

  static screenH() {
    return _height;
  }

  static topBarH() {
    return _topBarH;
  }

  static bottomBarH() {
    return _bottomBarH;
  }
}
