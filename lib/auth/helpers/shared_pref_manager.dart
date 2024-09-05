import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static final SharedPrefManager _instance = SharedPrefManager._internal();

  factory SharedPrefManager() {
    return _instance;
  }

  SharedPrefManager._internal();

  Future<void> saveData(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw Exception("Invalid type");
    }
  }

  Future<dynamic> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<void> deleteData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<bool> containsKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
