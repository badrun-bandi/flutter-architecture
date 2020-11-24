import 'dart:developer';

import 'package:flutter_architecture_starter/service/shared-preference/shared_preference.service.dart';

import 'base.facade.dart';

// One facade responsibility to get Shared Preference instance across pages
// Extends for single responsibility. ex: UserPreferenceFacade, AppPreferenceFacade
class SharedPreferenceFacade extends BaseFacade {
  final SharedPreferenceService sharedPreferenceService =
      SharedPreferenceService();
  static String userNameKey = 'userName';

  SharedPreferenceFacade() : super();

  Future<String> getUsername() async {
    return await sharedPreferenceService
        .getStringPreference(userNameKey)
        .then((value) {
      log('[getUsername] Preference Value: $value',
          name: 'SharedPreferenceFacade');
      return value;
    });
  }

  Future<void> setUsername(String value) async {
    log('[setUsername] Preference Value : $value, Key : $userNameKey',
        name: 'SharedPreferenceFacade');
    return await sharedPreferenceService.setStringPreference(
        userNameKey, value);
  }
}
