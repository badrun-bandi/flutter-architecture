import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/screen/album.page.dart';
import 'package:flutter_architecture_starter/screen/home.page.dart';
import 'package:flutter_architecture_starter/screen/login.page.dart';
import 'package:flutter_architecture_starter/screen/record.page.dart';

class AppRoutes {
  static const String album = '/album';
  static const String main = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String record = '/record';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
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
          fullscreenDialog: false,
        );
      case AppRoutes.record:
        return MaterialPageRoute<dynamic>(
          builder: (_) => RecordPage(title: 'Record Page'),
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
