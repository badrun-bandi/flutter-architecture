import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_architecture_starter/model/translation.dart';
import 'package:flutter_architecture_starter/service/localization/localization.service.dart';

class JsonLocalizationService extends LocalizationService {
  @override
  Future<Translation> load(Locale locale, {Translation translation}) async {
    // Load the language JSON file from the "lang" folder
    var jsonString = await rootBundle
        .loadString('lib/i18n/locale/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Translation(jsonMap);
  }
}
