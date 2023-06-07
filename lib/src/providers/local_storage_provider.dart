import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageKeys {
  TODO_LIST,
}

class LocalStorageProvider {
  Future<String?> readValue(LocalStorageKeys key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.name);
  }

  Future<void> writeValue(LocalStorageKeys key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.name, value);
  }

  Future<void> deleteAllValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  String getLocalStorageKey(LocalStorageKeys key) {
    switch (key) {
      case LocalStorageKeys.TODO_LIST:
        return "todo_list";
      default:
        return '';
    }
  }
}
