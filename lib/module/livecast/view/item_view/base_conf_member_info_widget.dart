import 'package:flutter_demo/extension/int_extension.dart';
import 'package:flutter_demo/util/image_loader.dart';
import 'package:flutter/material.dart';

import '../../../../util/adapt.dart';
import '../../model/conference_entity.dart';


/// 每一项的点击事件
typedef ItemClickCallBack = void Function(ConferenceMember member);

/// Created by fanjiajia02 on 2022/10/10
/// Desc: 成员列表item的基类，提供基础能力, 不同类型的成员项继承基类，每个类型专注于自己的场景
/// 申请列表[ApplyConfMemberInfoWidget]
/// 已入会[JoinedConfMemberInfoWidget]
/// 未入会[UnJoinConfMemberInfoWidget]
abstract class BaseConfMemberInfoWidget extends StatefulWidget {

  final ConferenceMember member;

  final ItemClickCallBack? itemClickCallBack;

  const BaseConfMemberInfoWidget({Key? key, required this.member, this.itemClickCallBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() => buildState();

  /// 由子类去实现
  BaseConfMemberInfoState buildState();
}

abstract class BaseConfMemberInfoState<T extends BaseConfMemberInfoWidget> extends State<T> {

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);
    return GestureDetector(
      onTap: () => widget.itemClickCallBack?.call(widget.member), // 这一项的点击事件
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        child: Container(
          width: double.infinity,
          height: 56.px,
          // color: _backgroundColor, // item可不指定背景色，由底层面板统一提供
          child: buildRowData(),
        ),
      ),
    );
  }

  /// 由各个业务类自己实现这一行的内容
  Widget buildRowData();


  /// 以下提供一些基础的组件构建能力

  /// 头像
  Widget buildHeader() {
    var headerImg = ImageLoader.load(_getImageBasePath('person_default_head.svg'));
    return Container(
      width: 28.px,
      height: 28.px,
      alignment: Alignment.center,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(14.px)),
          child: headerImg),
    );
  }

  /// 名称
  Widget buildName(String name) {
    return Text(
      name,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white, fontSize: 16.px),
      textAlign: TextAlign.start,
    );
  }

  /// 构造圆角按钮
  Widget buildRoundButton(String text,
      {GestureTapCallback? tapCallback,
      Color? color,
      Color? borderColor,
      Color? textColor = Colors.black}) {
    return GestureDetector(
      onTap: tapCallback,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(54.px)),
            color: color,
            border:
                borderColor == null ? null : Border.all(color: borderColor)),
        child: Padding(
            padding: EdgeInsets.fromLTRB(10.px, 3.px, 10.px, 4.px),
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }

  /// 构造 主播 等标签
  Widget buildTags(String text, double textSize, Color bgColor, Color textColor,
      double radius) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.px)),
          color: bgColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
        child: Text(
          text,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
      ),
    );
  }

  Widget? buildDingIcon() {
    return ImageLoader.load(_getImageBasePath("icon_member_list_ding.svg",), width: 22.px, height: 22.px,);
  }

  Widget? buildMicMuteIcon(bool mute) {
    var muteIcon = mute ? "icon_member_list_mic_close.svg" : "icon_member_list_mic_open.svg";
    return ImageLoader.load(_getImageBasePath(muteIcon),  width: 22.px, height: 22.px,);
  }

  Widget? buildCameraMuteIcon(bool mute) {
    var muteIcon = mute ? "icon_member_list_camera_close.svg" : "icon_member_list_camera_open.svg";
    return ImageLoader.load(_getImageBasePath(muteIcon),  width: 22.px, height: 22.px,);
  }

  /// 本地图片基地址
  String _getImageBasePath(String imgName) {
    return 'images/live_cast/$imgName';
  }

}
