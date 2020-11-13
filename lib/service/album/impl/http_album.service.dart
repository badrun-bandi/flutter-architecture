import 'dart:convert';

import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/service/album/mapper/album.mapper.dart';
import 'package:http/http.dart' as http;

import '../album.service.dart';

class HttpAlbumService extends AlbumService {
  Future<Album> fetchAlbum() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/1');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AlbumMapper().fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Album> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      'https://jsonplaceholder.typicode.com/albums/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return AlbumMapper().fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
