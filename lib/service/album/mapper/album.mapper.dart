import 'dart:developer';

import 'package:flutter_architecture_starter/model/album.dart';

class AlbumMapper {
  fromJson(Map<String, dynamic> json) {
    log('data: $json');
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  convert() {
    return Album();
  }
}
