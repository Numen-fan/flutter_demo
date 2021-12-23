import 'package:counter_flutter_demo/route/pop_route.dart';
import 'package:counter_flutter_demo/widgets/popup_widget.dart';
import 'package:flutter/material.dart';

///构建用户头像按钮
///点击头像弹出退出按钮
Widget _buildUserIcon() {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 22, 0, 0),
    child: GestureDetector(
      child: Container(
          child: Image.asset(
            "assets/images/logo.jpg",
          ),
          width: 32,
          height: 32,
          alignment: AlignmentDirectional.bottomStart),
      onTap: null,
    ),
  );
}

///构建退出按钮
Widget _buildExit() {
  return Container(
    width: 91,
    height: 36,
    child: Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/exit.png",
          fit: BoxFit.fill,
        ),
        const Center(
          child: Text(
            "退出", style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

///弹出退出按钮
///点击退出调用onClick
void _showExit(BuildContext context) {
  Navigator.push(context, PopRoute(child: Popup(
    child: _buildExit(),
    left: 64,
    top: 22,
    onClick: (){
      print("exit");
    },
  ),),);
}