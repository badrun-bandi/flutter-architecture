import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture_starter/model/translation.dart';
import 'package:flutter_architecture_starter/service/localization/impl/json_localization.service.dart';
import 'package:flutter_architecture_starter/service/localization/localization.service.dart';
import 'package:flutter_architecture_starter/utils/common_utils.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.main.dart';

class LocalizationFacade {
  static final LocalizationFacade _instance = LocalizationFacade._internal();

  static LocalizationFacade of(BuildContext context) =>
      Localizations.of<LocalizationFacade>(context, LocalizationFacade);

  Locale currentLocale;
  Map<String, Translation> translation = <String, Translation>{};
  List<Locale> supportedLocales;
  String path;
  bool saveLocale;
  Locale startLocale;
  Locale fallbackLocale;
  AppMain parent;

  final RegExp _replaceArgRegex = RegExp(r'{}');
  LocalizationService localizationService;

  LocalizationFacade._internal() {
    localizationService = JsonLocalizationService();
  }

  factory LocalizationFacade(
      {Locale currentLocale,
      List<Locale> supportedLocales,
      bool saveLocale,
      Locale startLocale,
      Locale fallbackLocale}) {
    var loc = _instance.currentLocale;
    log('[Factory] Current Locale: $loc. New Locale: $currentLocale',
        name: 'LocalizationFacade');
    // _instance.currentLocale = currentLocale ?? _instance.currentLocale;
    _instance.supportedLocales = supportedLocales ?? _instance.supportedLocales;
    _instance.saveLocale = saveLocale ?? _instance.saveLocale;
    _instance.startLocale = startLocale ?? _instance.startLocale;
    _instance.fallbackLocale = fallbackLocale ?? _instance.fallbackLocale;
    return _instance;
  }

  Future<LocalizationFacade> load(Locale locale,
      {List<Locale> supportedLocale}) async {
    log('[Load] Start. Current locale : $currentLocale, New locale: $locale',
        name: 'LocalizationFacade');
    if (locale != null &&
        _instance.currentLocale != null &&
        _instance.currentLocale != locale) {
      log('[Load] Change locale. Current locale : $currentLocale, New locale: $locale',
          name: 'LocalizationFacade');
      _instance.currentLocale = locale;
      return await _loadLocalization(locale: locale)
          .then((_) => SynchronousFuture<LocalizationFacade>(_instance));
    }
    if (locale != null && _instance.currentLocale == null) {
      log('[Load] Set local. Current locale : $currentLocale, New locale: $locale',
          name: 'LocalizationFacade');
      _instance.currentLocale = locale;
      return await _loadLocalization(locale: locale)
          .then((_) => SynchronousFuture<LocalizationFacade>(_instance));
    }
    if (locale == null && _instance.currentLocale == null) {
      log('[Load] Load default local. Current locale : $currentLocale, New locale: $locale',
          name: 'LocalizationFacade');
      return await _init().then((facade) =>
          _loadLocalization(locale: facade.currentLocale)
              .then((_) => SynchronousFuture<LocalizationFacade>(_instance)));
    }
    log('[Load] Load existing. Current locale : $currentLocale, New locale: $locale',
        name: 'LocalizationFacade');
    return SynchronousFuture<LocalizationFacade>(_instance);
  }

  Future<LocalizationFacade> _loadLocalization(
      {@required Locale locale}) async {
    log('[Load Localization] Current Locale: $currentLocale',
        name: 'LocalizationFacade');
    if (_instance.translation != null &&
        _instance.translation.isNotEmpty &&
        _instance.translation. containsKey(locale.toString())) {
      log('[Load] Load existing Localization from Cache: $locale',
          name: 'LocalizationFacade');
      return _instance;
    }
    return await localizationService
        .load(currentLocale)
        .then((Translation translation) {
      var translationValue = translation.toString();
      log('[Load Localization] Translation JSON : $translationValue',
          name: 'LocalizationFacade');
      _instance.translation.putIfAbsent(locale.toString(), ()=>  translation);
      return _instance;
    });
  }

  Future<LocalizationFacade> _init() async {
    log('[Init]', name: 'LocalizationFacade');
    Locale _savedLocale;
    Locale _osLocale;

    if (saveLocale != null && saveLocale) {
      _savedLocale = await loadSavedLocale();
    }
    if (_savedLocale == null && startLocale != null) {
      currentLocale = _getFallbackLocale(supportedLocales, startLocale);
      log('[init] Start locale loaded ${currentLocale.toString()}',
          name: 'LocalizationFacade');
    }
    // If saved locale then get
    else if (_savedLocale != null && saveLocale) {
      currentLocale = _getFallbackLocale(supportedLocales, _savedLocale);
      log('[init] Saved locale loaded ${currentLocale.toString()}',
          name: 'LocalizationFacade');
    } else {
      // Get Device Locale
      _osLocale = await _getDeviceLocale();
      currentLocale = supportedLocales.firstWhere(
          (Locale locale) => _checkInitLocale(locale, _osLocale),
          orElse: () => _getFallbackLocale(supportedLocales, fallbackLocale));
      log('[init] OS locale loaded ${currentLocale.toString()}',
          name: 'LocalizationFacade');
    }

    log('[init] Locale loaded: ${currentLocale.toString()} -  ${supportedLocales.toString()}',
        name: 'Localization');
    return await _loadLocalization(locale: currentLocale);
  }

  String translate(String key,
      {List<String> args, Map<String, String> namedArgs, String gender}) {
    String res;
    if (gender != null) {
      res = _gender(key, gender: gender);
    } else {
      res = _resolve(key);
    }
    res = _replaceNamedArgs(res, namedArgs);
    return _replaceArgs(res, args);
  }

  String _replaceArgs(String res, List<String> args) {
    if (args == null || args.isEmpty) return res;
    args.forEach((String str) => res = res.replaceFirst(_replaceArgRegex, str));
    return res;
  }

  String _replaceNamedArgs(String res, Map<String, String> args) {
    if (args == null || args.isEmpty) return res;
    args.forEach((String key, String value) =>
        res = res.replaceAll(RegExp('{$key}'), value));
    return res;
  }

  String plural(String key, num value, {NumberFormat format}) {
    final res = Intl.pluralLogic(value,
        zero: _resolvePlural(key, 'zero'),
        one: _resolvePlural(key, 'one'),
        two: _resolvePlural(key, 'two'),
        few: _resolvePlural(key, 'few'),
        many: _resolvePlural(key, 'many'),
        other: _resolvePlural(key, 'other'),
        locale: currentLocale.languageCode);
    return _replaceArgs(res, [
      format == null ? '$value' : format.format(value),
    ]);
  }

  String _gender(String key, {String gender}) => Intl.genderLogic(
        gender,
        female: _resolve(key + '.female'),
        male: _resolve(key + '.male'),
        other: _resolve(key + '.other', logging: false),
        locale: currentLocale.languageCode,
      );

  String _resolvePlural(String key, String subKey) {
    var locale = currentLocale.toString();
    final resource = translation.containsKey(locale) ? translation[locale].get('$key.$subKey') : null;
    if (resource == null && subKey == 'other') {
      CommonUtils.printError('Plural key [$key.$subKey] required');
      return '$key.$subKey';
    } else {
      return resource;
    }
  }

  String _resolve(String key, {bool logging = true}) {
    log('[_resolve] Key : $key', name: 'Localization');
    var locale = currentLocale.toString();
    final resource = translation.containsKey(locale) ? translation[locale].get(key) : null;
    if (resource == null) {
      if (logging) {
        CommonUtils.printWarning('Localization key [$key] not found');
      }
      return key;
    }
    return resource;
  }

  bool _checkInitLocale(Locale locale, Locale _osLocale) {
    // If supported locale not contain countryCode then check only languageCode
    if (locale.countryCode == null) {
      return (locale.languageCode == _osLocale.languageCode);
    } else {
      return (locale == _osLocale);
    }
  }

  //Get fallback Locale
  Locale _getFallbackLocale(
      List<Locale> supportedLocales, Locale fallbackLocale) {
    //If fallbackLocale not set then return first from supportedLocales
    if (fallbackLocale != null && supportedLocales.contains(fallbackLocale)) {
      return fallbackLocale;
    } else {
      return supportedLocales.first;
    }
  }

  // Get Device Locale
  Future<Locale> _getDeviceLocale() async {
    final _deviceLocale = await findSystemLocale();
    log('Device locale $_deviceLocale', name: 'Localization');
    return CommonUtils.localeFromString(_deviceLocale);
  }

  Future<Locale> loadSavedLocale() async {
    final _preferences = await SharedPreferences.getInstance();
    final _strLocale = _preferences.getString('locale');
    final locale =
        _strLocale != null ? CommonUtils.localeFromString(_strLocale) : null;
    return locale;
  }
}
