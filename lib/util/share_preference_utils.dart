import 'package:shared_preferences/shared_preferences.dart';

/// Created by fanjiajia02 on 2023/3/30
/// Desc: SharePreferenceUtils

class SharedPreferencesUtils {



  static saveInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int> getInt(String key, {int defaultVal = 0}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }
}
