import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/screen/album.page.dart';
import 'package:flutter_boilerplate/screen/home.page.dart';
import 'package:flutter_boilerplate/screen/login.page.dart';

class AppRoutes {
  static const album = '/album';
  static const main = '/';
  static const login = '/login';
  static const home = '/home';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(title: 'Home Page'),
          settings: settings,
          fullscreenDialog: false,
        );
      case AppRoutes.login:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginPage(),
          settings: settings,
          fullscreenDialog: false,
        );
      case AppRoutes.album:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AlbumPage(title: 'Album Page'),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.main:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
