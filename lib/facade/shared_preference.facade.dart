import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_starter/service/shared-preference/shared_preference.service.dart';

import 'base.facade.dart';

// One facade responsibility to get Shared Preference instance across pages
// Extends for single responsibility. ex: UserPreferenceFacade, AppPreferenceFacade
class SharedPreferenceFacade extends BaseFacade {
  final sharedPreferenceService = SharedPreferenceService();
  static const userNameKey = 'userName';

  final BuildContext context;
  SharedPreferenceFacade({@required this.context}) : super(context: context);

  Future<String> getUsername() async {
    return await sharedPreferenceService.getStringPreference(userNameKey);
  }

  Future<String> setUsername(String value) async {
    await sharedPreferenceService.setStringPreference(userNameKey, value);
  }
}
