import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/screen/main.page.dart';
import 'package:flutter_boilerplate/service/album/album.service.dart';
import 'package:flutter_boilerplate/service/album/impl/http_album.service.dart';
import 'package:provider/provider.dart';

import 'facade/album.facade.dart';
import 'model/counter.dart';

class AppProvider {
  Widget page;
  AppProvider({@required this.page});

  MultiProvider multiProvider() {
    return MultiProvider(
      providers: [
        Provider<AlbumService>(
          create: (context) => HttpAlbumService(),
        ),
        Provider<AlbumFacade>(
          create: (context) => AlbumFacade(context: context),
        ),
        ChangeNotifierProvider<Counter>(
          create: (context) => Counter(),
        ),
      ],
      child: this.page,
    );
  }
}
