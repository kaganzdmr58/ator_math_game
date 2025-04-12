import 'package:shared_preferences/shared_preferences.dart';

Future<void> setPrefInt(String key, int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<void> setPrefBool(String key, bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setBool(key, value);
}

Future<void> setPrefDouble(String key, double value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(key, value);
}

Future<void> setPrefString(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<void> setPrefStringList(String key, List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(key, value);
}

Future<int?> getPrefInt(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

Future<bool?> getPrefBool(
    {required String key}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool(key);
}

Future<double?> getPrefDouble(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(key);
}

Future<String?> getPrefString(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<List<String>?> getPrefStringList(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key);
}

Future<void> removePref(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
