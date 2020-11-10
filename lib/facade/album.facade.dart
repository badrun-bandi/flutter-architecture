import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/model/album.dart';
import 'package:flutter_boilerplate/service/album/album.service.dart';
import 'package:provider/provider.dart';

import 'base.facade.dart';

class AlbumFacade extends BaseFacade {
  AlbumService albumService;
  List<Album> albums = [];

  final BuildContext context;
  AlbumFacade({@required this.context}) : super(context: context) {
    albumService = Provider.of<AlbumService>(this.context, listen: false);
  }

  getAlbum(){
   return albumService.fetchAlbum();
  }

}