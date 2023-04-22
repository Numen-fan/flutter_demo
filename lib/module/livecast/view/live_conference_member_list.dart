
import 'package:flutter_demo/extension/int_extension.dart';
import 'package:flutter_demo/module/livecast/model/conference_entity.dart';
import 'package:flutter_demo/module/livecast/view/item_view/apply_conf_member_Info_widget.dart';
import 'package:flutter_demo/module/livecast/view/item_view/unjoin_conf_member_info_widget.dart';
import 'package:flutter_demo/util/adapt.dart';
import 'package:flutter_demo/util/toast_utils.dart';
import 'package:flutter/material.dart';

import 'item_view/joined_conf_member_info_widget.dart';


/// Created by fanjiajia02 on 2022/10/10
/// Desc: 成员列表
class LiveConferenceMemberList extends StatefulWidget {

  static const String route = "MemberListPage";

  static const String _TAG = route;

  const LiveConferenceMemberList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LiveConferenceMemberListState();
  }
}

class LiveConferenceMemberListState extends State<LiveConferenceMemberList> {

  //todo mock date
  var applyMembers = [
    ConferenceMember(1, "", "康美美"),
    ConferenceMember(1, "", "李彪彪")
  ];
  var joinedMembers = [
    ConferenceMember(1, "", "素娜娜", isSelf: true, muteAudio: false),
    ConferenceMember(1, "", "谢梅梅谢梅梅谢梅梅谢梅梅", isHost: true, isVipTop: true, muteVideo: false)
  ];
  var unJoinMembers = [
    ConferenceMember(1, "", "周景景", state: MemberState.waiting),
    ConferenceMember(1, "", "李志林")
  ];
  late var items;

  final _backgroundColor = Color(0xFF262629);
  final _dividerColor = Color(0xFF3F3F42);

  @override
  void initState() {
    super.initState();
    items = [applyMembers, joinedMembers, unJoinMembers];
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);
    return Expanded(child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        _buildGroups("申请列表", 0),
        insertDivider(_dividerColor, padding: 12.px),
        _buildGroups("已进入直播", 1),
        insertDivider(_dividerColor, padding: 12.px),
        _buildGroups("未进入直播", 2),
      ],
    );
  }

  Widget _buildGroups(String title, int index) {
    List<Widget> viewItems = _buildMemberListWidget(index);
    return WrapExpansionTile(viewItems: viewItems, title: title);
  }

  /// 构建不同类型的成员列表
  List<Widget> _buildMemberListWidget(int type) {
    if (type == 0) {
      return items[type]
          .map<Widget>((member) => ApplyConfMemberInfoWidget(
                member: member,
                acceptOrRefuseCallback: _acceptOrRefuseApply,
              ))
          .toList();
    } else if (type == 1) {
      return items[type]
          .map<Widget>((member) => JoinedConfMemberInfoWidget(
                member: member,
                itemClickCallBack: _joinedMemberClickListener,
              ))
          .toList();
    } else {
      return items[type]
          .map<Widget>((member) => UnJoinConfMemberInfoWidget(
                member:member,
                inviteMemberCallback: _inviteMember,
              ))
          .toList();
    }
  }

  /// 插入水平分割线
  Widget insertDivider(Color color, {double? height, double padding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Divider(
        height: height ?? 1.0,
        color: color,
      ),
    );
  }

  /*
    ====== start of 成员管理事件 =========
   */

  /// 接受或者拒绝申请连麦
  void _acceptOrRefuseApply(bool accept, ConferenceMember member) {
    ToastUtil.showToast("accept $accept, name is ${member.displayName}");
  }

  /// 入会成员的点击事件
  void _joinedMemberClickListener(ConferenceMember member) {
    ToastUtil.showToast( "你选择了 ${member.displayName}");
  }

  /// 邀请成员入会
  void _inviteMember(ConferenceMember member) {
    ToastUtil.showToast( "你邀请了 ${member.displayName}");
  }
}

/*
  ====== end of 成员管理事件 =========
 */

/// 分组列表组件，包含一个title，和这个分组的子列表。
/// 组件细化，可以做到不同类型的列表单独刷新
class WrapExpansionTile extends StatefulWidget {

  final List<Widget> viewItems;
  final String title;

  const WrapExpansionTile(
      {Key? key, required this.viewItems, required this.title});

  @override
  State<StatefulWidget> createState() => WrapExpansionTileState();
}

class WrapExpansionTileState extends State<WrapExpansionTile> with SingleTickerProviderStateMixin {

  late final animationController;
  late var animation;

  // 展开状态，默认为展开
  bool expand = true;

  final _titleColor = Color(0xFF9EA0A3);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation =  Tween(begin: 0.0, end: 0.25).animate(animationController);
    animationController.forward(from: 0.25);
  }


  @override
  Widget build(BuildContext context) {
    print("build ${widget.title}");
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ), // 去掉ExpansionTile内部的分割线
      child: ExpansionTile(
        initiallyExpanded: expand,
        controlAffinity: ListTileControlAffinity.leading,
        onExpansionChanged: _changeExpandState,
        leading: RotationTransition(
          turns: animation,
          child: Icon(
            Icons.arrow_right_rounded,
            size: 30.px,
            color: _titleColor,
          ),
        ),
        title: Align(
          alignment: const Alignment(-1.2, 0), // 默认的title间隔较大
          child: Text(
            widget.title + "（${widget.viewItems.length}）",
            style: TextStyle(color: _titleColor, fontSize: 16.px),
          ),
        ),
        tilePadding: EdgeInsets.symmetric(horizontal: 5.px),
        children: widget.viewItems,
      ),
    );
  }

  /// 改变折叠状态
  _changeExpandState(bool exp) {
    expand = exp;
    setState(() {
      if (expand) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

}


