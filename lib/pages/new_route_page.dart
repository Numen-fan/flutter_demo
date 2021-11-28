import 'package:flutter/material.dart';

class NewRoutePage extends StatelessWidget {
  const NewRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Route"),
      ),
      body: const Center(
        child: Text("This is new route"),
      ),
    );
  }
}
