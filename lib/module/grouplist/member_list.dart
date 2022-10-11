import 'package:counter_flutter_demo/extension/int_extension.dart';
import 'package:counter_flutter_demo/module/grouplist/member_info_item.dart';
import 'package:counter_flutter_demo/util/utils.dart';
import 'package:flutter/material.dart';

import '../../util/adapt.dart';

class MemberListPage extends StatefulWidget {
  static const String route = "MemberListPage";

  const MemberListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MemberListState();
  }
}

class MemberListState extends State<MemberListPage> with TickerProviderStateMixin {

  var items = [1,2, 3, 4,1,2, 3, 4,1,2, 3, 4,1,2, 3, 4];
  
  final _backgroundColor = const Color(0xFF262629);
  final _titleColor = const Color(0xFF9EA0A3);

  late var animations;
  late var animationControllers;

  var expands = [true, true, true]; // 三个分组的展开情况

  @override
  void initState() {
    final animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    final animationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    final animationController3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    final animation1 = Tween(begin: 0.0, end: 0.25).animate(animationController1);
    final animation2 = Tween(begin: 0.0, end: 0.25).animate(animationController2);
    final animation3 = Tween(begin: 0.0, end: 0.25).animate(animationController3);
    animations = [animation1, animation2, animation3];
    animationControllers = [animationController1, animationController2, animationController3];
    animationController1.forward(from: 0.25);
    animationController2.forward(from: 0.25);
    animationController3.forward(from: 0.25);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("成员列表"),
      ),
      body: Container(
        color: _backgroundColor,
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        _buildGroups("申请列表", 0),
        Utils.insertDivider(color: const Color(0xFF3F3F42)),
        _buildGroups("已入会", 1),
        Utils.insertDivider(color: const Color(0xFF3F3F42)),
        _buildGroups("未入会", 2),
      ],
    );
  }

  /// 构建分组title
  Widget _buildGroups(String title, int index) {
    print("build $title");
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ), // 去掉ExpansionTile内部的分割线
      child: ExpansionTile(
        initiallyExpanded: expands[index],
        maintainState: true,
        controlAffinity: ListTileControlAffinity.leading,
        onExpansionChanged: (expand) {
          _changeExpandState(expand, index);
        },
        leading: RotationTransition(
          turns: animations[index],
          child: Icon(
            Icons.arrow_right_rounded,
            size: 30.px,
            color: _titleColor,
          ),
        ),
        title: Align(
          alignment: const Alignment(-1.2, 0), // 默认的title间隔较大
          child: Text(
            title + "(2/3)",
            style: TextStyle(color: _titleColor, fontSize: 16.px),
          ),
        ),
        tilePadding: EdgeInsets.symmetric(horizontal: 5.px),
        children:
            items.map((name) => MemberInfoItemWidget(name: "我叫$name")).toList(),
      ),
    );
  }

  /// 改变折叠状态
  _changeExpandState(bool expand, int index) {
    expands[index] = !expands[index]; // 记录折叠状态
    setState(() {
      if (expand) {
        animationControllers[index].forward();
      } else {
        animationControllers[index].reverse();
      }
    });
  }
}


