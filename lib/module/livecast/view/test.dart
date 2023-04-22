

import 'dart:convert';

import 'package:flutter_demo/module/livecast/model/conference_entity.dart';

void main () {

  Conference conference = Conference(10086, "confName", 0, 10098, "10086");

  ConferenceMember member1 = ConferenceMember(100778, "dsdsd", "张三", isHost: false);
  ConferenceMember member2 = ConferenceMember(100708, "dsdsd", "张三2", isHost: true);

  var members = [member1, member2];

  Map<String, dynamic> confInfo = {"conf_info": conference, "members": members};
  Map<String, dynamic> map = {"data": confInfo};

  print(jsonEncode(confInfo));

}
