import 'package:flutter_demo/extension/int_extension.dart';
import 'package:flutter_demo/util/adapt.dart';
import 'package:flutter/material.dart';

class MemberInfoItemWidget extends StatefulWidget {

  final String name;

  const MemberInfoItemWidget({Key? key, required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemberInfoItemState();

}

class _MemberInfoItemState extends State<MemberInfoItemWidget> {

  final _backgroundColor = const Color(0xFF262629);

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Container(
        width: double.infinity,
        height: 56.px,
        color: _backgroundColor,
        child: Row(
          children: [
            Text(
              widget.name,
              style: TextStyle(color: Colors.white, fontSize: 16.px),
            )
          ],
        ),
      ),
    );
  }

}