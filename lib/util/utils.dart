
import 'package:flutter/material.dart';

class Utils {

  /// 插入分割线
  static Widget insertDivider({required Color color, double? height}) {
    return Divider(height: height ?? 1, color: color);
  }
}
