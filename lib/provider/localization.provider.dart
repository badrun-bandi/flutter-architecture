import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_starter/facade/localization.facade.dart';
import 'package:flutter_architecture_starter/model/translation.dart';

class LocalizationProvider extends InheritedWidget {
  static LocalizationDelegate delegate = LocalizationDelegate();

  final bool saveLocale;
  final List<Locale> supportedLocales;
  final Locale startLocale;
  final Locale fallbackLocale;
  final Locale currentLocale;

  Future<LocalizationFacade> load() async {
    // Load external locale change or set default state during init.
    log('[Load] Current Locale: $currentLocale', name: 'LocalizationProvider');
    return await LocalizationFacade(
        currentLocale: currentLocale,
            supportedLocales: supportedLocales,
            saveLocale: saveLocale,
            startLocale: startLocale,
            fallbackLocale: fallbackLocale
          ).load(currentLocale);
  }

  LocalizationProvider({
    Key key,
    this.currentLocale,
    this.supportedLocales,
    this.saveLocale,
    this.startLocale,
    this.fallbackLocale,
    Widget child
  }) : super(key: key, child: child) {
    log('[Constructor] Current Locale: $currentLocale', name: 'LocalizationProvider');
  }

  @override
  bool updateShouldNotify(LocalizationProvider oldWidget) {
    log('[updateShouldNotify] Value : $oldWidget', name: 'LocalizationProvider');
    return true;
  }

  // @override
  // bool updateShouldNotify(LocalizationProvider oldWidget) {
  //   var oldLocale = oldWidget.currentLocale;
  //   var locale = currentLocale;
  //   log('Notify oldLocale : $oldLocale - $locale', name: 'LocalizationProvider');
  //   return oldLocale != locale;
  // }

  static LocalizationProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocalizationProvider>();

}

class LocalizationDelegate extends LocalizationsDelegate<LocalizationFacade> {
  List<Locale> supportedLocales;
  // static final Map<Locale, Future<LocalizationFacade>> _loadedTranslations =
  //     <Locale, Future<LocalizationFacade>>{};

  ///  * use only the lang code to generate i18n file path like en.json or ms.json
  @override
  LocalizationDelegate() {
    supportedLocales = LocalizationFacade().supportedLocales;
    log('[Init] Supported Locale: $supportedLocales',
        name: 'LocalizationDelegate');
  }

  // @override
  // bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  bool isSupported(Locale locale) {
    var isSupported = supportedLocales.contains(locale);
    log('[isSupported] Supported Locale: $supportedLocales : Current Locale: $locale',
        name: 'LocalizationDelegate');
    return isSupported;
  }

  // Static member to have a simple access to the delegate.dart from the MaterialApp
  static LocalizationsDelegate<LocalizationFacade> delegate = LocalizationDelegate();

  @override
  Future<LocalizationFacade> load(Locale locale, {Translation translation}) async {
    log('[Load] Current Locale: $locale', name: 'LocalizationDelegate');
    var instance = await LocalizationFacade(
        currentLocale: locale, supportedLocales: supportedLocales)
        .load(locale);
    return SynchronousFuture<LocalizationFacade>(instance);
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationFacade> old) => false;
}
