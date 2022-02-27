import 'package:counter_flutter_demo/util/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogPage extends StatelessWidget {

  static const String routeName = "DialogPage";

  const DialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dialog page"),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => DialogUtils.showSingleButtonDialog(
                      context, content: "测试单个按钮对话框", btn: "知道了",
                  clickListener:() => debugPrint("我知道了")),
              child: const Text("单按钮对话框"),
            ),
            
           const Padding(padding: EdgeInsets.only(top: 20)),
           
           GestureDetector(
             onTap: () =>
                 DialogUtils.showDoubleButtonDialog(context,
                  title: "提示",
                  content: "我是两个按钮的对话框",
                  leftBtn: "知道了",
                  rightBtn: "不知道",
                   leftClick: () => debugPrint("知道了")
                 ),
              child: const Text("双按钮对话框"),
           ) 
            
          ],
        )
    );
  }

}