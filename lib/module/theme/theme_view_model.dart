import 'package:flutter_demo/module/theme/theme_store.dart';
import 'package:flutter_demo/util/share_preference_utils.dart';
import 'package:flutter/material.dart';

/// Created by fanjiajia02 on 2023/3/30
/// Desc:

class ThemeViewModel extends ChangeNotifier {

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeViewModel() {
    _init();
  }

  void _init() async {
    _themeMode = await ThemeStore.getThemeMode();
  }

  setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    ThemeStore.setThemeMode(_themeMode);
  }

  void setInitModel(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

}