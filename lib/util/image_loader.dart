import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Image load util
class ImageLoader {
  static Widget? load(String? url, {double? width, double? height, Color? color}) {
    if(url == null || url.isEmpty) {
      return null;
    }
    width ??= double.infinity;
    height ??= width;
    if (url.endsWith(".png") || url.endsWith(".jpg")) {
      return Image.asset(
        url,
        width: width,
        height: height,
      );
    } else if (url.endsWith(".svg")) {
      return SvgPicture.asset(
        url,
        width: width,
        height: height,
        color: color,
      );
    }
  }
}
