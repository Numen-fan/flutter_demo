import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HttpRequestPage extends StatefulWidget {

  static const String routeName = "HttpRequestPage";

  const HttpRequestPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HttpRequestPageState();

}

class HttpRequestPageState extends State<HttpRequestPage> {

  bool _loading = false;
  String _content = "";
  
  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Http请求"),),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 20.0, width: double.infinity,),
      //       ElevatedButton(
      //         onPressed: _loading ? null : request,
      //         child: const Text("HttpClient request"),
      //       ),
      //       const SizedBox(height: 20.0, width: double.infinity,),
      //
      //       ElevatedButton(
      //         onPressed: _loading ? null : request,
      //         child: const Text("Dio request"),
      //       ),
      //
      //       const SizedBox(height: 20.0, width: double.infinity,),
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width - 50.0,
      //         child: Text(_content),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return ListView(
                children: response.data.map<Widget>((e) =>
                    ListTile(title: Text(e["full_name"]),)).toList(),
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void request() async {
    setState(() {
      _loading = true;
      _content = "正在请求……";
    });

    try {
      // 1 创建HttpClient实例
      HttpClient httpClient = HttpClient();

      // 2 构建请求任务
      HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));

      // 3 发起请求
      HttpClientResponse response = await request.close();

      // 4 读取返回数据
      _content = await response.transform(utf8.decoder).join();
      debugPrint(response.headers.toString());

      // 5 关闭请求
      httpClient.close();
    } catch (e) {
      _content = "请求失败：error is $e";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
  

}