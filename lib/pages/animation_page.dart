import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Created by fanjiajia02 on 2023/4/13
/// Desc:

class AnimationPage extends StatelessWidget {
  static const routeName = "AnimationPage";

  const AnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = [1, 2, 3, 4, 5, 6, 7, 8];
    var threshold = items.length - items.length % 3; // 第threshold是空白
    var cnt = items.length + (items.length % 3 == 0 ? 0 : 2); // 前后有空白
    return Scaffold(
      appBar: AppBar(
        title: Text("动画"),
      ),
      body: GridView.builder(
        shrinkWrap:true,
        itemCount: cnt,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 3 / 4, // 子元素宽高比
          mainAxisSpacing: 8.0, // 垂直间距
          crossAxisSpacing: 8.0, // 水平间距
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == threshold || index == cnt -1) {
            // 添加空白item
            return Container(color: Colors.white,);
          } else {
            // 添加实际item
            return GridItemWidget(index);
          }
        },
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {

  final int index;

  const GridItemWidget(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        color: Colors.blueAccent,
        alignment: Alignment.center,
        child: Text("$index"),
      ),
    );
  }

}
