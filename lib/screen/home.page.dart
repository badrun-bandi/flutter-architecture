import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_starter/facade/album.facade.dart';
import 'package:flutter_architecture_starter/facade/localization.facade.dart';
import 'package:flutter_architecture_starter/facade/shared_preference.facade.dart';
import 'package:flutter_architecture_starter/model/album.dart';
import 'package:flutter_architecture_starter/model/counter.dart';
import 'package:provider/provider.dart';

import '../app.main.dart';
import 'album.page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  // Future<void> _showAlbumPage(BuildContext context) async {
  //   final navigator = Navigator.of(context);
  //   await navigator.pushNamed(
  //     AppRoutes.album,
  //     arguments: () => navigator.pop(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var sharedPreferenceFacade =
        Provider.of<SharedPreferenceFacade>(context, listen: false);
    var albumFacade = Provider.of<AlbumFacade>(context, listen: false);
    // var futureAlbum = albumFacade.get();
    var appMain = AppMain.stateOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(appMain.currentLocale.toString()),
            Text(LocalizationFacade.of(context).translate('Message')),
            Text(Localizations.localeOf(context).languageCode),
            Text(MaterialLocalizations.of(context).closeButtonLabel),
            Text('You have pushed the button this many times:'),
            // Consumer looks for an ancestor Provider widget
            // and retrieves its model (Counter, in this case).
            // Then it uses that model to build widgets, and will trigger
            // rebuilds if the model is updated.
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Consumer<Record>(
              builder: (context, record, child) => Text(
                '${record.title}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            FutureBuilder<List<Record>>(
              future: albumFacade.get(),
              builder: (context, snapshot) {
                // log('snapshot: $snapshot');
                if (snapshot.hasData) {
                  return Text('Saved Album: ${snapshot.data.first.title}');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder<String>(
              future: sharedPreferenceFacade.getUsername(),
              builder: (context, snapshot) {
                // log('snapshot: $snapshot');
                if (snapshot.hasData) {
                  return Text('Saved Album: ${snapshot.data}');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            RaisedButton(
              color: Colors.yellow,
              child: Text('ENTER'),
              onPressed: () {
                AlbumPage.show(context);
              },
            ),
            RaisedButton(
              color: Colors.yellow,
              child: Text(appMain.currentLocale.toString()),
              onPressed: () {
                if (appMain?.currentLocale?.languageCode == 'en') {
                  appMain.changeLocale(Locale('ms', 'MY'));
                } else {
                  appMain.changeLocale(Locale('en', 'US'));
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can access your providers anywhere you have access
          // to the context. One way is to use Provider<Counter>.of(context).
          //
          // The provider package also defines extension methods on context
          // itself. You can call context.watch<Counter>() in a build method
          // of any widget to access the current state of Counter, and to ask
          // Flutter to rebuild your widget anytime Counter changes.
          //
          // You can't use context.watch() outside build methods, because that
          // often leads to subtle bugs. Instead, you should use
          // context.read<Counter>(), which gets the current state
          // but doesn't ask Flutter for future rebuilds.
          //
          // Since we're in a callback that will be called whenever the user
          // taps the FloatingActionButton, we are not in the build method here.
          // We should use context.read().
          var counter = context.read<Counter>();
          counter.increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
