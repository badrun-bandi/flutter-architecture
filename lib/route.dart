
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/screen/album.page.dart';
import 'package:flutter_boilerplate/screen/home.page.dart';
import 'package:flutter_boilerplate/screen/login.page.dart';

final appRoutes =
{
  '/': (context) => LoginPage(),
  '/login': (context) => LoginPage(),
  '/home': (context) => HomePage(title: 'Home Page'),
  '/album': (context) => AlbumPage(title: 'Album Page'),
};

class AppRoutes {
  static const album = '/album';
}

class MainRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.album:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AlbumPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
      // TODO: Throw
        return null;
    }
  }
}