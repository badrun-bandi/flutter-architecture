import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/facade/album.facade.dart';
import 'package:flutter_architecture_starter/facade/shared_preference.facade.dart';
import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/model/counter.dart';
import 'package:flutter_architecture_starter/screen/widget/text_form_field.widget.dart';
import 'package:provider/provider.dart';

import '../route.dart';

class RecordPage extends StatelessWidget {
  final String title;
  RecordPage({Key key, this.title}) : super(key: key);

  void _showHomePage(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    navigator.pop();
  }

  static Future<void> show(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    await navigator.pushNamed(AppRoutes.record);
  }

  @override
  Widget build(BuildContext context) {
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
    var albumFacade = Provider.of<AlbumFacade>(context, listen: true);
    if (albumFacade.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text(
      'LOAD',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPage(BuildContext context) {
    var albumFacade = Provider.of<AlbumFacade>(context, listen: true);
    var futureRecord = albumFacade.getRecord(null);
    // var sharedPreferenceFacade =
    //     Provider.of<SharedPreferenceFacade>(context, listen: true);
    final myController = TextEditingController();
    return Center(
      child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
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
                FutureBuilder<Record>(
                  future: futureRecord,
                  builder: (context, snapshot) {
                    // log('snapshot: $snapshot');
                    if (snapshot.hasData) {
                      return Text('Saved Album: ${snapshot.data.title}');
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
                // Consumer<AlbumFacade>(
                //     builder: (context, record, child) => FutureBuilder<Record>(
                //           future: futureRecord,
                //           builder: (context, snapshot) {
                //             if (snapshot.hasData) {
                //               myController.text = snapshot.data.title;
                //               return TextField(
                //             controller: myController);
                //             } else if (snapshot.hasError) {
                //               return Text('${snapshot.error}');
                //             }
                //             return CircularProgressIndicator();
                //           },
                //         )),
                Consumer<Counter>(
                  builder: (context, counter, child) => Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                RaisedButton(
                  color: Colors.yellow,
                  child: Text('REFRESH'),
                  onPressed: () {
                    albumFacade.getRecord(null);
                  },
                ),
                RaisedButton(
                    color: Colors.yellow,
                    child: Text('REFRESH'),
                    onPressed: () {
                      //futureAlbum = albumFacade.get();
                      var albumFacade2 = context.read<AlbumFacade>();
                      albumFacade2.getRecord(null);
                    }),
                RaisedButton(
                  color: Colors.green,
                  child: Text('SAVE TO PREFERENCE'),
                  onPressed: () {
                    // sharedPreferenceFacade
                    //     .setUsername(myController.text);
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
