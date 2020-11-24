import 'dart:async';
import 'dart:math';

import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/service/album/mapper/album.mapper.dart';
import 'package:http/http.dart' as http;

import '../album.service.dart';

class HttpAlbumService extends AlbumService {

  @override
  Future<List<Record>> fetchAlbum() async {
    // int random = new Random().nextInt(100);
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AlbumMapper().fromJsonAlbum(response.body);
      // return compute(AlbumMapper().fromJsonAlbum, response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Future<Record> fetchRecord(int id) async {
    var query = id ?? Random().nextInt(30);
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/$query');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AlbumMapper().fromJsonRecord(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load records');
    }
  }

  @override
  Future<List<Record>> deleteAlbum(String id) async {
    final response = await http.delete(
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
      return AlbumMapper().fromJsonAlbum(response.body);
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
