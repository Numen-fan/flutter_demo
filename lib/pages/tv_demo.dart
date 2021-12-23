import 'package:counter_flutter_demo/util/ImageLoader.dart';
import 'package:counter_flutter_demo/widgets/click_state_imgae_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TvDemoPage extends StatefulWidget {
  static const String routeName = "TvDemoPage";

  const TvDemoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TvDemoState();
}

class _TvDemoState extends State<TvDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: getAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: ClickStateImageWidget.fromColor(
                    type: Type.color,
                    normalImgUrl: "images/member.svg",
                    activeColor: const Color(0xFF0000FF),
                    normalColor: const Color(0xFFFF0000)),
              ),
            ),
          ),
          // 底部部分
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1C1D1F),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: Colors.black45,
      elevation: 0,
      title: const Text("手机遥控器", style: TextStyle(color: Colors.white)),
      centerTitle: true,
      leading: UnconstrainedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: ImageLoader.load("images/mini.svg", width: 28),
          )),
      actions: [
        UnconstrainedBox(
          child: ImageLoader.load("images/more.svg", width: 28),
        ),
        const Padding(padding: EdgeInsets.only(left: 18)),
        UnconstrainedBox(
          child: ImageLoader.load("images/close.svg", width: 28),
        ),
        const Padding(padding: EdgeInsets.only(left: 18)),
      ],
    );
  }
}
