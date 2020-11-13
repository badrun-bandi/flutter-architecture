import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

// Shared implementation for easy migration and upgrade
class SharedPreferenceService {
  Future<SharedPreferences> _sharedPreferences;

  SharedPreferenceService() {
    init();
  }

  init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = SharedPreferences.getInstance();
    }
  }

  Future<void> setStringPreference(String key, String value) async {
    SharedPreferences prefs = await this._sharedPreferences;
    prefs.setString(key, value);
  }

  Future<String> getStringPreference(String key) async {
    SharedPreferences prefs = await this._sharedPreferences;
    String stringValue = prefs.getString(key);
    return stringValue;
  }
}
