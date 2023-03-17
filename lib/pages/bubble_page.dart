import 'package:counter_flutter_demo/popup_window/popup_menu.dart';
import 'package:counter_flutter_demo/widgets/custom_popup_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BubblePage extends StatefulWidget {

  static const String routeName = "BubblePage";

  const BubblePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BubblePageState();

}

class BubblePageState extends State<BubblePage> {

  OverlayEntry? popEntry;

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    final GlobalKey<BubblePageState> targetKey =  GlobalKey();
    final GlobalKey<BubblePageState> targetKey2 = GlobalKey();

    PopupMenu menu = PopupMenu(
        context: context,
        backgroundColor: Colors.blue,
        items: [
          MyMenuItem(title: "当前是增强会议", textStyle: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
        ],
    );

    var popTips = CustomPopupWindow(
        context: context,
        alignment: PopAlignment.down,
        arrowOffset: -30,
        child: Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          child: const Text("我是普通会议", style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,),),
        ),
        height: 30, width: 100,
        backgroundColor: Colors.blue);

    return Scaffold(
      appBar: AppBar(title: const Text("Bubble demo"),),
      body: WillPopScope(
        onWillPop: () async {
          closePopTips();
          return true;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap: () => menu.show(widgetKey: targetKey),
                  child: Text("气泡1", key: targetKey, style: const TextStyle(color: Colors.black54, fontSize: 24),)),

              SizedBox(height: 50,),

              GestureDetector(
                  onTap: () {
                    popEntry = popTips.show(targetGlobalKey: targetKey2);
                  },
                  child: Text("气泡2", key: targetKey2, style: const TextStyle(color: Colors.black54, fontSize: 24),)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    closePopTips();
  }

  void closePopTips() {
    // 只能remove一次，但是多个地方调用remove，因此这里
    popEntry?.remove();
    popEntry = null;
  }
}