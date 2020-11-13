import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/service/album/album.service.dart';
import 'package:provider/provider.dart';

import 'base.facade.dart';

class AlbumFacade extends BaseFacade {
  AlbumService albumService;
  List<Album> albums = [];

  final BuildContext context;
  AlbumFacade({@required this.context}) : super(context: context) {
    albumService = Provider.of<AlbumService>(this.context, listen: false);
  }

  Future<Album> getAlbum() {
    try {
      isLoading = true;
      // notifyListeners();
      error = null;
      return albumService.fetchAlbum();
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      // notifyListeners();
    }
  }
}
