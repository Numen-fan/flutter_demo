import 'dart:developer';

import 'package:flutter/material.dart';

class FormTestPage extends StatelessWidget {

  static const String routeName = "FormTestPage";

  const FormTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('表单测试页面')),
      body: const FormTestRoute(),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  const FormTestRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  final TextEditingController _unameControler = TextEditingController();
  final TextEditingController _pwdControler = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>(); // 全局key

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _unameControler,
              decoration: const InputDecoration(
                labelText: "用户名",
                hintText: "用户名或者邮箱",
                icon: Icon(Icons.person),
              ),
              // 校验用户名
              validator: (v) => v!.trim().isNotEmpty ? null : "用户名不能为空",
            ),
            TextFormField(
              controller: _pwdControler,
              decoration: const InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                icon: Icon(Icons.lock),
              ),
              obscureText: true, // 隐藏正在编辑的文本，用于输入密码等场景。
              // 校验密码
              validator: (v) => v!.trim().length > 5 ? null : "密码不能少于6位",
            ),
            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 10.0, right: 10.0), // 向上padding28逻辑像素
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("登录"),
                      ),
                      onPressed: () {
                        // 通过_formKey.currentState 获取FormState后，调用validate方法
                        // 校验用户名和密码是否合法，校验通过后再提交数据
                        if ((_formKey.currentState as FormState).validate()) {
                          log("校验通过，可以登录");
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
