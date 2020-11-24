import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_starter/service/album/album.service.dart';
import 'package:flutter_architecture_starter/service/album/impl/http_album.service.dart';
import 'package:provider/provider.dart';

import 'facade/album.facade.dart';
import 'facade/shared_preference.facade.dart';
import 'model/album.dart';
import 'model/counter.dart';

class AppMultiProvider {
  Widget app;

  AppMultiProvider({@required this.app});

  MultiProvider multiProvider() {
    return MultiProvider(
      providers: [
        // Provider<LocalizationService>(
        //   create: (BuildContext context) => JsonLocalizationService(),
        // ),
        ChangeNotifierProvider<AlbumFacade>(
          create: (context) => AlbumFacade(),
        ),
        ChangeNotifierProvider<SharedPreferenceFacade>(
          create: (context) => SharedPreferenceFacade(),
        ),
        Provider<AlbumService>(
          create: (context) => HttpAlbumService(),
        ),
        ChangeNotifierProvider<Counter>(
          create: (context) => Counter(),
        ),
        Provider<Album>(
          create: (context) => Album(),
        ),
       Provider<Record>(
          create: (context) => Record(),
        ),
      ],
      child: app,
    );
  }
}
