import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {

  /// 单按钮对话框
  static void showSingleButtonDialog(BuildContext context,
      {String? title,
      required String content,
      required String btn,
      VoidCallback? clickListener,
      bool barrierDismiss = true}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismiss,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title == null ? null : Text(title, style: const TextStyle(fontSize: 16),),
          content: Text(content),
          actions: [
            CupertinoActionSheetAction(onPressed: () {
              Navigator.pop(context);
              clickListener?.call();
            }, child: Text(btn))
          ],
        );
      },
    );
  }

  /// 双按钮对话框
  static void showDoubleButtonDialog(BuildContext context,
      {String? title,
      required String content,
      required String leftBtn,
      required String rightBtn,
       VoidCallback? leftClick,
       VoidCallback? rightClick,
      bool barrierDismiss = true}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismiss,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title == null ? null : Text(title, style: const TextStyle(fontSize: 16),),
          content: Text(content),
          actions: [
            CupertinoActionSheetAction(onPressed: () {
              Navigator.pop(context);
              leftClick?.call();
            }, child: Text(leftBtn)),
            CupertinoActionSheetAction(onPressed: () {
              Navigator.pop(context);
              rightClick?.call();
            }, child: Text(rightBtn)),
          ],
        );
      },
    );
  }
}
