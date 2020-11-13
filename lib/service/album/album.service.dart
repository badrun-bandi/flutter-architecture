import 'package:flutter_architecture_starter/model/album.dart';

import '../base.service.dart';

abstract class AlbumService extends BaseService {
  Future<Album> fetchAlbum();
  Future<Album> deleteAlbum(String id);
}
