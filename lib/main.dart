import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/provider.dart';
import 'package:flutter_architecture_starter/provider/localization.provider.dart';
import 'package:flutter_architecture_starter/route.dart';
import 'package:flutter_architecture_starter/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app.main.dart';

final List<Locale> supportedLocales = const <Locale>[
  Locale('en', 'US'),
  Locale('ms', 'MY'),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget widget = AppMain(
    supportedLocales: supportedLocales,
    saveLocale: true,
    startLocale: const Locale('en', 'US'),
    fallbackLocale: const Locale('en', 'US'),
    currentLocale: const Locale('en', 'US'),
    child: Builder(
      builder: (BuildContext context) => MaterialApp(
        title: 'Flutter Boilerplate',
        theme: AppThemeData.appTheme,
        supportedLocales: supportedLocales,
        localizationsDelegates: [
          LocalizationDelegate.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        onGenerateRoute: (RouteSettings settings) =>
            AppRouter.onGenerateRoute(settings),
      ),
    ),
  );

  runApp(AppMultiProvider(app: widget).multiProvider());
}
