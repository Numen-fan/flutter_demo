import 'package:flutter/cupertino.dart';
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
          const Expanded(
            child: Center(
              child: Text("我是中间部分", style: TextStyle(color: Colors.white),),
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
            child: const Text("我是底部部分", style: TextStyle(color: Colors.white),),
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
            child: SvgPicture.asset("images/mini.svg", width: 28),
          )),
      actions: [
        UnconstrainedBox(
          child:SvgPicture.asset("images/more.svg", width: 28),
        ),
        const Padding(padding: EdgeInsets.only(left: 18)),
        UnconstrainedBox(
          child: SvgPicture.asset("images/close.svg", width: 28),
        ),
        const Padding(padding: EdgeInsets.only(left: 18)),
      ],
    );
  }
}
