import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/facade/album.facade.dart';
import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/model/counter.dart';
import 'package:flutter_architecture_starter/screen/album.page.dart';
import 'package:flutter_architecture_starter/screen/record.page.dart';
import 'package:provider/provider.dart';

class AlbumState extends State<AlbumPage> {
  bool isLoading;
  List<Record> records;

  AlbumState({
    this.isLoading = false,
  });

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    developer.log('[initState] Init', name: 'AppState');
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await get();
  }

  Future<List<Record>> get() async {
    return await AlbumFacade().get();
  }

  Future<Record> getRecord() async {
    return await AlbumFacade().getRecord(null);
  }

  factory AlbumState.loading() => AlbumState(isLoading: true);

  Widget _buildHeader(BuildContext context) {
    var albumFacade = Provider.of<AlbumFacade>(context, listen: false);
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

  void _showHomePage(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    developer.log('[Build] ', name: 'AlbumState');
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          title: Text('Album@'),
        ),
        backgroundColor: Colors.grey[200],
        body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: min(constraints.maxWidth, 600),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // const SizedBox(height: 32.0),
                    SizedBox(
                      height: 30.0,
                      child: _buildHeader(context),
                    ),
                    Expanded(
                        child: Consumer<AlbumFacade>(
                          builder: (context, counter, child) => FutureBuilder<List<Record>>(
                            future: get(),
                            builder: (context, snapshot) {
                              // log('snapshot: $snapshot');
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(Icons.wb_sunny),
                                      title: Text(snapshot.data[index].title),
                                      trailing: Icon(Icons.keyboard_arrow_right),
                                      onTap: () {
                                        print('Moon');
                                      },
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text('${snapshot.error}');
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                              color: Colors.yellow,
                              child: Text('REFRESH'),
                              onPressed: () {
                                //futureAlbum = albumFacade.get();
                                var albumFacade2 = context.read<AlbumFacade>();
                                albumFacade2.get();
                              }),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RaisedButton(
                              color: Colors.yellow,
                              child: Text('RECORD'),
                              onPressed: () {
                                RecordPage.show(context);
                              },
                            ),
                          ),
                          RaisedButton(
                            color: Colors.green,
                            child: Text('BACK'),
                            onPressed: () {
                              _showHomePage(context);
                            },
                          )
                        ]),
                  ]),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var counter = context.read<Counter>();
            counter.increment();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));



  }
}
