import 'package:shared_preferences/shared_preferences.dart';

class ShareDataBase {
  ShareDataBase();

  Future<bool?> saveDouble(String key, double value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool result = await prefs.setDouble(key, value);
      return result;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<double?> getDouble(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      double? result = prefs.getDouble(key);
      return result;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<bool?> saveString(String key, String value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool result = await prefs.setString(key, value);
      return result;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<String?> getString(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(key);
      return result;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
