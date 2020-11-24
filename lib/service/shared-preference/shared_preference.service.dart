import 'package:shared_preferences/shared_preferences.dart';

import '../base.service.dart';

// Service implementation for easy migration and upgrade
class SharedPreferenceService extends BaseService {
  Future<SharedPreferences> _sharedPreferences;
  static final SharedPreferenceService _instance =
      SharedPreferenceService._internal();

  factory SharedPreferenceService() {
    return _instance;
  }

  // SharedPreferenceService() : super() {
  //   init();
  // }

  SharedPreferenceService._internal() : super() {
    _sharedPreferences ??= SharedPreferences.getInstance();
  }

  // void init() async {
  //   _sharedPreferences ??= SharedPreferences.getInstance();
  // }

  Future<void> setStringPreference(String key, String value) async {
    var prefs = await _sharedPreferences;
    await prefs.setString(key, value);
  }

  Future<String> getStringPreference(String key) async {
    var prefs = await _sharedPreferences;
    var stringValue = prefs.getString(key);
    return stringValue;
  }
}
