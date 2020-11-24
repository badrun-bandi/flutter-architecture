import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/provider/localization.provider.dart';
import 'package:flutter_architecture_starter/state/app.state.dart';

class AppMain extends StatefulWidget {
  final List<Locale> _supportedLocales;
  final Locale _currentLocale;
  final Locale _fallbackLocale;
  final Locale _startLocale;
  final bool _saveLocale;
  final Widget _child;

  AppMain(
      {Key key,
      @required supportedLocales,
      saveLocale,
      @required fallbackLocale,
      @required startLocale,
      @required currentLocale,
      @required child})
      : assert(child != null),
        assert(fallbackLocale != null),
        assert(startLocale != null),
        assert(supportedLocales != null && supportedLocales.isNotEmpty),
        _supportedLocales = supportedLocales,
        _currentLocale = currentLocale,
        _saveLocale = saveLocale,
        _fallbackLocale = fallbackLocale,
        _startLocale = startLocale,
        _child = child,
        super(key: key) {
    log('Start', name: 'AppMain');
  }

  List<Locale> get supportedLocales => _supportedLocales;
  bool get saveLocale => _saveLocale;
  Locale get currentLocale => _currentLocale;
  Locale get fallbackLocale => _fallbackLocale;
  Locale get startLocale => _startLocale;
  Widget get child => _child;

  // static AppState of(BuildContext context) {
  //   return (context.dependOnInheritedWidgetOfExactType(aspect: StateContainer)
  //   as StateContainer).data;
  // }

  static AppState stateOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateProvider>().state;
  }

  static LocalizationProvider localizationProviderOf(BuildContext context) =>
      LocalizationProvider.of(context);

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}
