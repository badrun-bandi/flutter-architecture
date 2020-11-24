import 'dart:convert';
import 'dart:developer';

import 'package:flutter_architecture_starter/model/album.dart';

class AlbumMapper {
  Record fromJsonRecord(String json) {
    final map = jsonDecode(json);
    var title = map['title'];
    log('$title', name:'AlbumMapper');
    return Record(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  Record fromJsonMapRecord(Map<String, dynamic> map) {
    return Record(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  List<Record> fromJsonAlbum(String json) {
    // developer.log('data: $json');
    //final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    //List<Record> itemsList = parsed.map<Record>((json) => fromJsonRecord(json)).toList();
    final List<dynamic> dynamicAlbum = jsonDecode(json);
    var itemsList =
        List<Record>.from(dynamicAlbum.map((i) => fromJsonMapRecord(i)));
    return itemsList;
  }

  Record convert() {
    return Record();
  }
}
