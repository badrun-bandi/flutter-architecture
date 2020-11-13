import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/theme/theme.dart';

import '../route.dart';

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: AppThemeData.appTheme,
      // initialRoute: '/',
      // routes: appRoutes,
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
