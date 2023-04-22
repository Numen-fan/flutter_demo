
import 'package:flutter_demo/extension/int_extension.dart';
import 'package:flutter_demo/module/livecast/model/conference_entity.dart';
import 'package:flutter_demo/util/adapt.dart';
import 'package:flutter/material.dart';

import 'base_conf_member_info_widget.dart';


/// Created by fanjiajia02 on 2022/10/10
/// Desc: 已入会成员详情项
class JoinedConfMemberInfoWidget extends BaseConfMemberInfoWidget{

  const JoinedConfMemberInfoWidget(
      {Key? key,
      required ConferenceMember member,
      required ItemClickCallBack itemClickCallBack})
      : super(key: key, member: member, itemClickCallBack: itemClickCallBack);

  @override
  BaseConfMemberInfoState<BaseConfMemberInfoWidget> buildState() => _JoinedConfMemberInfoState();

}

class _JoinedConfMemberInfoState extends BaseConfMemberInfoState<JoinedConfMemberInfoWidget> {

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
    list.add(_buildNameAndTags());

    if (widget.member.isVipTop) {
      list.add(buildDingIcon()!);
      list.add(SizedBox(width: 10.px,));
    }

    list.add(buildCameraMuteIcon(widget.member.muteVideo)!);
    list.add(SizedBox(width: 10.px,));
    list.add(buildMicMuteIcon(widget.member.muteAudio)!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  Widget _buildNameAndTags() {
    Widget baseNameWgt =  buildName(widget.member.displayName + (widget.member.isSelf ? "(我)" : ""));

    if(!widget.member.isHost) {
      return Expanded(child: baseNameWgt);
    }

    // 需要在名称后面构建标签, 同时需要满足name占用最大空间
    LayoutBuilder layoutBuilder = LayoutBuilder(builder: (context, constrains) {
      List<Widget> nameList = [];
      Widget constrainsName = ConstrainedBox(
        constraints: BoxConstraints(minWidth: 0, maxWidth: constrains.maxWidth - 50.px),
        child: baseNameWgt,
      );
      nameList.add(constrainsName);
      if (widget.member.isHost) {
        nameList.add(SizedBox(width: 8.px));
        nameList.add(buildTags("主播", 11.px, Color(0x335B8DF0), Color(0xFF6D9AF4), 2.px));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: nameList,
      );
    });
    
    return Expanded(child: layoutBuilder);
  }

}