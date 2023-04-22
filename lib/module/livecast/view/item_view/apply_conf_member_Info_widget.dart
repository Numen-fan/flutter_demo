import 'package:flutter_demo/extension/int_extension.dart';
import 'package:flutter_demo/module/livecast/model/conference_entity.dart';
import 'package:flutter_demo/util/adapt.dart';
import 'package:flutter/material.dart';


import 'base_conf_member_info_widget.dart';

/// 对申请成员的操作，拒绝 or 同意
typedef AcceptOrRefuseCallback = void Function(bool accept, ConferenceMember member);

/// Created by fanjiajia02 on 2022/10/10
/// Desc: 申请成为嘉宾成员详情项

class ApplyConfMemberInfoWidget extends BaseConfMemberInfoWidget{

  final AcceptOrRefuseCallback acceptOrRefuseCallback;

  const ApplyConfMemberInfoWidget({Key? key, required member, required this.acceptOrRefuseCallback})
      : super(key: key, member: member);

  @override
  BaseConfMemberInfoState<BaseConfMemberInfoWidget> buildState() => _ApplyConfMemberInfoState();

}

class _ApplyConfMemberInfoState extends BaseConfMemberInfoState<ApplyConfMemberInfoWidget> {

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);
    return super.build(context);
  }

  @override
  Widget buildRowData() {
    List<Widget> list = [];

    // 头像
    list.add(buildHeader());
    list.add(SizedBox(width: 12.px));

    // 名称 & 名称后面的标签
    list.add(Expanded(child: buildName("${widget.member.displayName}申请成为嘉宾")));

    // 拒绝按钮
    list.add(buildRoundButton("拒绝",
        borderColor: Colors.white,
        textColor: Colors.white,
        tapCallback: _refuseCallback));

    list.add(SizedBox(width: 10.px,));

    // 同意按钮
    list.add(buildRoundButton("同意",
        color: Color(0xFFD9D9D9), tapCallback: _acceptCallback));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  /// 接受申请
  void _acceptCallback() {
    widget.acceptOrRefuseCallback(true, widget.member);
  }

  void _refuseCallback() {
    widget.acceptOrRefuseCallback(false, widget.member);
  }
}