import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_app/widgets/lazyAppBar.dart';
import 'package:lazy_app/widgets/lazyExpansionTile.dart';
import 'package:lazy_app/widgets/lazySwitchTile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class FirebaseInitialize extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            appBar: LazyAppBar(),
            body: Center(
              child: Text('Please chec your internet and restart app'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          appBar: LazyAppBar(),
          body: Center(
            child: Text('Make this better'),
          ),
        );
        ;
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LazyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LazyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            LazyExpansionTile(
              roomCode: 'LR',
              roomName: 'Living Room',
              children: [
                LazySwitchTile(
                  name: 'Hello World',
                  deviceCode: 'CD',
                  fbValue: false,
                ),
                LazySwitchTile(
                  name: 'Hello World',
                  deviceCode: 'CD',
                  fbValue: false,
                ),
                LazySwitchTile(
                  name: 'Hello World',
                  deviceCode: 'CD',
                  fbValue: false,
                ),
                LazySwitchTile(
                  name: 'Hello World',
                  deviceCode: 'CD',
                  fbValue: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
