import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static Future<bool> setPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String> getPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}