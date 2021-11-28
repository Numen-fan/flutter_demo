
import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

// StatefulWidget表示有状态的组件
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // 该方法，是先自增，然后调用setState通知Flutter框架，状态发生变化，随后会调用build方法
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 每次都会new一个Scaffold吗？
    return Scaffold(
      // Scafford是Material库提供的页面脚手架，默认提供了导航栏appBar和页面内容body部分
      appBar: AppBar(
        title: Text(widget.title), // 获取widget中的字段
      ),
      body: Center(
        //Center组件可以将其子组件树对齐到屏幕中心。
        child: Column(
          // Column将其所有子组件沿屏幕垂直方向依次排列
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              child: const Text("open new route"),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const NewRoute();
                // }));

                // 通过命名路由打开页面
                Navigator.pushNamed(context, "from_test_route");
              },
            ),
            const RandomWordWidget(),
            const Image(
              image: AssetImage("images/logo.jpg"),
              width: 100,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RandomWordWidget extends StatelessWidget {
  const RandomWordWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final word = WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(word.toString()),
    );
  }
}