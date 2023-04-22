import 'package:flutter_demo/extension/int_extension.dart';
import 'package:flutter_demo/util/adapt.dart';
import 'package:flutter_demo/util/toast_utils.dart';
import 'package:flutter/material.dart';

import '../../../util/image_loader2.dart';
import 'live_conference_member_list.dart';

/// Created by fanjiajia02 on 2022/10/12
/// Desc: 成员列表页面

class LiveConferenceMemberPage extends StatefulWidget {

  static const route = "LiveConferenceMemberPage";
  final _TAG = route;

  const LiveConferenceMemberPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LiveConferenceMemberPageState();

}

class LiveConferenceMemberPageState extends State<LiveConferenceMemberPage> {

  final _backgroundColor = Color(0xFF262629);

  /// 左右两侧的间距
  final _horizontalMargin = 16.px;

  final _searchMemberEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchMemberEditingController.addListener(_textFieldContentChanged);
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);

    List<Widget> contents = [];
    // 顶部搜索栏
    contents.add(_buildSearchArea());

    // todo 根据搜索框的聚焦情况，绘制不同的布局

    // 中部成员列表
    contents.add(const LiveConferenceMemberList());

    // todo 主持人具备底部静音全员等操作区域
    contents.add(_buildBottomManageArea());

    return WillPopScope(
      onWillPop: () async { // 处理返回手势
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 键盘弹出时，不改变布局
        backgroundColor: _backgroundColor, // 背景色
        appBar: _buildAppBar(),
        body: Column(
          children: contents,
        ),
      ),
    );
  }

  /// 1、顶部title 和 右侧关闭按钮
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: _backgroundColor,
      title: Text("嘉宾列表", style: TextStyle(color: Colors.white, fontSize: 15.px),),
      centerTitle: true,
      actions: [
        UnconstrainedBox(
          child: GestureDetector(
            onTap: _closePage,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _horizontalMargin),
                child: ImageLoader(_getImageBasePath("icon_member_list_close.svg"), width: 22.px, height: 22.px,)),
          ),
        )
      ],
    );
  }

  /// 2、顶部搜索框和添加成员区域
  Widget _buildSearchArea() {
    // 搜索输入框
    BorderRadius radius = BorderRadius.all(Radius.circular(18.px));
    TextField searchTextField = TextField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(fontSize: 14.px, color: Colors.white),
      controller: _searchMemberEditingController,
      decoration: InputDecoration(
        prefixIcon: UnconstrainedBox(
            child: ImageLoader(
          _getImageBasePath("icon_member_list_search.svg"),
          width: 15.px,
          height: 15.px,
        )),
        hintText: "搜索或邀请",
        hintStyle: TextStyle(fontSize: 14.px, color: const Color(0xFFA0A0A3)),
        fillColor: const Color(0xFF303033),
        filled: true,
        contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 0), // 设置此属性才能使得文字居中
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: radius,
        ),
      ),
    );
    
    Widget addMemberButton = GestureDetector(
      onTap: _addMember,
      child: ImageLoader(_getImageBasePath("icon_member_list_add_member.svg"), width: 22.px, height: 22.px,),
    );

    Widget cancelTxt = GestureDetector(
      onTap: _cancelSearch,
      child: Text("取消", style: TextStyle(fontSize: 16.px, color: Colors.white),
      ),
    );

    // 搜索框聚焦时，尾部显示『取消』，否着显示添加成员
    Widget tailWidget = addMemberButton;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _horizontalMargin),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.px,
          maxHeight: 36.px,
        ),
        child: Row(
          children: [
            Expanded(child: searchTextField),
            SizedBox(width: _horizontalMargin,),
            tailWidget
          ],
        ),
      ),
    );
  }

  /// 底部静音全员等控制区域
  Widget _buildBottomManageArea() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.px, top: 16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBottomMuteAllManageButton(true),
          SizedBox(width: 8.px,),
          _buildBottomMuteAllManageButton(false),
        ],
      ),
    );
  }

  Widget _buildBottomMuteAllManageButton(bool muteAll) {
    String text = muteAll ? "静音全员" : "取消静音全员";
    String iconName = muteAll ? "icon_member_list_mic_close.svg" : "icon_member_list_mic_open.svg";
    return GestureDetector(
      onTap: muteAll ? _muteAll : _unMuteAll,
      child: Container(
        width: 100.px,
        height: 60.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.px)),
          color: const Color(0xFF303033),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.px, bottom: 4.px),
              child: ImageLoader(_getImageBasePath(iconName), width: 21.px, height: 21.px,),),
            Text(text, style: TextStyle(fontSize: 14.px, color: Colors.white),)
          ],
        ),
      ),
    );
  }

  /*
   * =============== start of 页面事件 ===========
   */

  _closePage() {
    ToastUtil.showToast("关闭列表");
  }

  _muteAll() {
    ToastUtil.showToast("静音全员");
  }

  _unMuteAll() {
    ToastUtil.showToast("取消静音全员");
  }
  
  _addMember() {
    ToastUtil.showToast("添加成员");
  }

  _cancelSearch() {
    ToastUtil.showToast("取消搜索");
  }

  /// 搜索框内容发生改变
  _textFieldContentChanged() {
    String content = _searchMemberEditingController.text;
    print(content);
  }

  /*
   * =============== end of 页面事件 ===========
   */


  /// 本地图片基地址
  String _getImageBasePath(String imgName) {
    return 'images/live_cast/$imgName';
  }
}