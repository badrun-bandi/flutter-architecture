import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/facade/album.facade.dart';
import 'package:flutter_architecture_starter/l10n/locale.dart';
import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/model/counter.dart';
import 'package:provider/provider.dart';

import '../route.dart';

// final albumFacade = ChangeNotifierProvider<AlbumFacade>();

class AlbumPage extends StatelessWidget {
  final String title;
  AlbumPage({Key key, this.title}) : super(key: key);
  AlbumFacade albumFacade;

  Future<void> _showHomePage(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    navigator.pop();
  }

  static Future<void> show(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    await navigator.pushNamed(AppRoutes.album);
  }

  @override
  Widget build(BuildContext context) {
    albumFacade = Provider.of<AlbumFacade>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          title: Text(title),
        ),
        backgroundColor: Colors.grey[200],
        body: _buildPage(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var counter = context.read<Counter>();
            counter.increment();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    if (albumFacade.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text(
      AppLocale.load,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPage(BuildContext context) {
    Future<Album> futureAlbum;
    albumFacade = Provider.of<AlbumFacade>(context, listen: false);
    futureAlbum = albumFacade.getAlbum();
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: min(constraints.maxWidth, 600),
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 32.0),
                SizedBox(
                  height: 50.0,
                  child: _buildHeader(context),
                ),
                FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    // log('snapshot: $snapshot');
                    if (snapshot.hasData) {
                      return Text(snapshot.data.title);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                RaisedButton(
                  color: Colors.yellow,
                  child: Text('ENTER'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/album');
                  },
                ),
                RaisedButton(
                  color: Colors.green,
                  child: Text('BACK'),
                  onPressed: () {
                    _showHomePage(context);
                  },
                )
              ]),
        );
      }),
    );
  }
}
