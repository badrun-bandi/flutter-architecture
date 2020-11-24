import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/facade/album.facade.dart';
import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/model/counter.dart';
import 'package:flutter_architecture_starter/screen/record.page.dart';
import 'package:flutter_architecture_starter/state/album.state.dart';
import 'package:provider/provider.dart';

import '../route.dart';

// final albumFacade = ChangeNotifierProvider<AlbumFacade>();

class AlbumPage extends StatefulWidget {
  final String title;
  AlbumPage({Key key, this.title}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    await navigator.pushNamed(AppRoutes.album);
  }

  @override
  State<StatefulWidget> createState() {
    return AlbumState();
  }
}
