import 'package:counter_flutter_demo/module/theme/theme_view_model.dart';
import 'package:counter_flutter_demo/util/share_preference_utils.dart';
import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/3/30
/// Desc:

class ThemeStore {
  static const _modeKey = "theme_mode"; // 用于持久化存储的key

  static ThemeMode? currentmode = null;

  static const Map<int, ThemeMode> modeMap = {
    0: ThemeMode.system,
    1: ThemeMode.light,
    2: ThemeMode.dark
  };

  static Future<ThemeMode> getThemeMode() async {
    if(currentmode != null) {
      return currentmode!;
    }
    int result = await SharedPreferencesUtils.getInt(_modeKey);
    print("持久化存储值为$result");
    currentmode = modeMap[modeMap.containsKey(result) ? result : 0]!;
    return currentmode!;
  }

  static void setThemeMode(ThemeMode themeMode) {
    SharedPreferencesUtils.saveInt(
        _modeKey,
        modeMap.entries
            .firstWhere((element) => element.value == themeMode)
            .key);
  }
}
