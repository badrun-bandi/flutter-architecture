import 'dart:developer';

import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/service/album/album.service.dart';
import 'package:flutter_architecture_starter/service/album/impl/http_album.service.dart';

import 'base.facade.dart';

class AlbumFacade extends BaseFacade {
  AlbumService albumService = HttpAlbumService();
  Future<List<Record>> _albums = Future.value([]);

  Future<List<Record>> get() async {
    await albumService
        .fetchAlbum()
        .then((value) => _albums = Future.value(value));
    if (_albums == null) {
      return await Future.value([]);
    }
    try {
      isLoading = true;
      error = null;
      return await _albums;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      // notifyListeners();
    }
  }

  Future<Record> getRecord(int id) async {

    try {
      isLoading = true;
      error = null;
      var record = await _albums.then((album) => album
          .singleWhere((Record record) => record.id == id, orElse: () => null));
      record ??= await albumService
          .fetchRecord(id)
          .then((Record item) => _albums.then((List<Record> records) {
                records.add(item);
                return item;
              }));
      return await record;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
