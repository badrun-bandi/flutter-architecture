import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/facade/localization.facade.dart';
import 'package:flutter_architecture_starter/provider/localization.provider.dart';

import '../app.main.dart';

class AppState extends State<AppMain> {
  List<Locale> supportedLocales;
  Locale currentLocale;
  bool isLoading;

  AppState({
    this.isLoading = false,
    this.supportedLocales = const [],
  });

  @override
  void dispose() {
    super.dispose();
  }

  void changeLocale(Locale locale) {
    setState(() {
      if (locale != currentLocale) {
        log('[changeLocale] Set State: new locale: $locale, current locale: $currentLocale',
            name: 'AppState');
        currentLocale = locale;
      }
    });
  }

  @override
  void initState() {
    log('[initState] Init', name: 'AppState');
    _init();
    super.initState();
  }

  Future<void> _init() async {
    // await load();
  }

  Future<LocalizationFacade> load() async {
    // Load external locale change or set default state during init.
    return await LocalizationFacade(
            supportedLocales: widget.supportedLocales,
            currentLocale: widget.currentLocale,
            saveLocale: widget.saveLocale,
            startLocale: widget.startLocale,
            fallbackLocale: widget.fallbackLocale)
        .load(currentLocale);
  }

  factory AppState.loading() => AppState(isLoading: true);

  @override
  Widget build(BuildContext context) {
    Widget child;
    log('[Build] ', name: 'AppState');
    return Container(
      child: FutureBuilder<LocalizationFacade>(
        future: LocalizationProvider(
                currentLocale: currentLocale,
                supportedLocales: widget.supportedLocales,
                saveLocale: widget.saveLocale,
                startLocale: widget.startLocale,
                fallbackLocale: widget.fallbackLocale)
            .load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData &&
              !snapshot.hasError) {
            log('[Build] Loading..', name: 'AppState');
            child = const CircularProgressIndicator();
          } else if (snapshot.hasData && !snapshot.hasError) {
            if (currentLocale != snapshot.data.currentLocale) {
              currentLocale = snapshot.data.currentLocale;
            }
            var path = snapshot.data.translation != null
                ? snapshot.data.translation[currentLocale.toString()].toString()
                : '';
            log('[Build] Has Data: $path', name: 'AppState');
            child = StateProvider(widget, state: this, child: widget.child);
          } else if (snapshot.hasError) {
            log(snapshot.toString(), name: 'AppState');
            child = Container();
          }
          return child;
        },
      ),
    );
  }

  // @override
  // int get hashCode =>
  //     supportedLocales.hashCode ^ currentLocale.hashCode ^ isLoading.hashCode;
  //
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //         other is AppState &&
  //             runtimeType == other.runtimeType &&
  //             currentLocale == other.currentLocale &&
  //             isLoading == other.isLoading;

}

class StateProvider extends InheritedWidget {
  final AppState state;
  final AppMain parent;

  StateProvider(this.parent,
      {Key key, @required this.state, @required Widget child})
      : super(key: key, child: child) {
    var supportedLocales = parent.supportedLocales;
    var currentLocales = state.currentLocale;
    log('[Constructor] Current Locale : $currentLocales, Supported Locales : $supportedLocales',
        name: 'StateProvider');
  }

  // @override
  //   bool updateShouldNotify(StateProvider oldWidget) {
  //     var oldLocale = oldWidget.state.currentLocale;
  //     var locale = state.currentLocale;
  //     log('Notify oldLocale : $oldLocale - $locale', name: 'StateProvider');
  //     var path = state.currentLocale.toString();
  //     log('Notify path: $path', name: 'StateProvider');
  //     return oldWidget.state != state;
  //   }

  /// Delegates to the underlying [value] hashCode.
  // @override
  // int get hashCode => state.hashCode;

  @override
  bool updateShouldNotify(StateProvider oldWidget) {
    log('[updateShouldNotify] Should Notify $oldWidget', name: 'StateProvider');
    return true;
  }

  static StateProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateProvider>();
  }

  // @override
  // bool operator == (Object other) {
  //   var oldLocale = other is StateProvider ? other.state.currentLocale : '';
  //   var newLocale = state.currentLocale;
  //   log('operator == : $oldLocale, $newLocale', name: 'StateProvider');
  //   return identical(this, other) ||
  //       other is StateProvider &&
  //           runtimeType == other.runtimeType &&
  //           state.currentLocale == other.state.currentLocale;
  // }

}
