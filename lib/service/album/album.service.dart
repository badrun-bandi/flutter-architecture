import 'package:flutter_architecture_starter/model/album.dart';

import '../base.service.dart';

abstract class AlbumService extends BaseService {
  Future<List<Record>> fetchAlbum();
  Future<List<Record>> deleteAlbum(String id);
  Future<Record> fetchRecord(int id);
}
