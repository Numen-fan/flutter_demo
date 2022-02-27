import 'package:flutter/material.dart';

/// Demo of ScrollController

class ScrollControllerTestPage extends StatefulWidget {

  static const String routeName = "ScrollControllerTestPage";

  const ScrollControllerTestPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScrollControllerPageState();

}

class ScrollControllerPageState extends State<ScrollControllerTestPage> {

  final ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // print(_scrollController.offset);
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() { // 注意单独在此处调用setState
          showToTopBtn = false;
        });
      } else if (_scrollController.offset > 1000 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose(); // 防止内存泄露
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ScrollControllerTestPage"),),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scrollbar(
          child: ListView.builder(
            itemCount: 100,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("$index"),);
            },
          ),
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }

}