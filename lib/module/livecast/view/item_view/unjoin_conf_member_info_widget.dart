import 'package:flutter_demo/extension/int_extension.dart';
import 'package:flutter_demo/module/livecast/model/conference_entity.dart';
import 'package:flutter_demo/module/livecast/view/item_view/base_conf_member_info_widget.dart';
import 'package:flutter/material.dart';

typedef InviteMemberCallback = void Function(ConferenceMember member);

/// Created by fanjiajia02 on 2022/10/11
/// Desc: 未加入成员详情项
class UnJoinConfMemberInfoWidget extends BaseConfMemberInfoWidget {

  final InviteMemberCallback inviteMemberCallback;

  const UnJoinConfMemberInfoWidget({Key? key, required ConferenceMember member,
    required this.inviteMemberCallback}) : super(key: key, member: member);

  @override
  BaseConfMemberInfoState<BaseConfMemberInfoWidget> buildState() => _UnJoinConfMemberInfoState();

}


class _UnJoinConfMemberInfoState extends BaseConfMemberInfoState<UnJoinConfMemberInfoWidget> {

  @override
  Widget buildRowData() {

    List<Widget> list = [];

    // 头像
    list.add(buildHeader());
    list.add(SizedBox(width: 12.px));

    // 名称
    list.add(Expanded(child: buildName(widget.member.displayName)));


    if (widget.member.state == MemberState.waiting) {
      // 已邀请
      list.add(buildRoundButton("已邀请", color: Colors.grey));
    } else {
      // 等待加入
      list.add(SizedBox(width: 10.px,));
      list.add(Text("等待进入", style: TextStyle(fontSize: 14.px, color: Color(0xFF939393)),));
      list.add(SizedBox(width: 10.px,));

      // 发送邀请
      list.add(buildRoundButton("发送邀请", color: Color(0xFFD9D9D9), tapCallback: _inviteMember));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  /// 发出邀请
  void _inviteMember() {
    widget.inviteMemberCallback(widget.member);
  }

}