import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// Created by fanjiajia02 on 2023/3/16
/// Desc:

class CustomListViewPage extends StatelessWidget {
  static const String routeName = "CustomListViewPage";

  const CustomListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("sticker_header"),
        ),
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              print("build$index");
              return StickyHeader(
                header: GestureDetector(
                  onTap: () => print("点击了$index"),
                  child: Container(
                    height: 50.0,
                    color: Colors.blueGrey[700],
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      "第$index组",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                content: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, i) {
                      print("开始build$index=>$i");
                      return Container(
                          width: double.infinity,
                          height: 60,
                          child: Text("第$i个选项"));
                    }),
              );
            },
            itemCount: 3));
  }

  Widget _getStickGroup(String title) {
    Widget content = ListView.builder(
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          print("开始build$title=>$index");
          return Container(
              width: double.infinity, height: 60, child: Text("第$index个选项"));
        });
    if ("我是第二个分组" == title) {
      content = Container();
    }
    return SliverList(
        delegate: SliverChildBuilderDelegate((_, index) {
      return StickyHeader(
        header: Container(
          height: 50.0,
          color: Colors.blueGrey[700],
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        content: content,
      );
    }, childCount: 1));
  }
}
