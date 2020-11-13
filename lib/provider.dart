import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_starter/service/album/album.service.dart';
import 'package:flutter_architecture_starter/service/album/impl/http_album.service.dart';
import 'package:provider/provider.dart';

import 'facade/album.facade.dart';
import 'facade/shared_preference.facade.dart';
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
        ChangeNotifierProvider<AlbumFacade>(
          create: (context) => AlbumFacade(context: context),
        ),
        ChangeNotifierProvider<SharedPreferenceFacade>(
          create: (context) => SharedPreferenceFacade(context: context),
        ),
        ChangeNotifierProvider<Counter>(
          create: (context) => Counter(),
        ),
      ],
      child: this.page,
    );
  }
}
