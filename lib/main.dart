import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_app/pages/HomePage.dart';
import 'package:lazy_app/services/firebaseService.dart';
import 'package:lazy_app/widgets/lazyAppBar.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FirebaseInitialize());
}

class FirebaseInitialize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<LazyFirebaseService>(
      create: (_) => LazyFirebaseService(),
      builder: (context, _) {
        return FutureBuilder(
          // Initialize FlutterFire:
          future: Provider.of<LazyFirebaseService>(context).initFirebaseApp(),
          builder: (context, AsyncSnapshot<FirebaseApp> snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return MaterialApp(
                home: Scaffold(
                  appBar: LazyAppBar(),
                  body: Center(
                    child: Text(snapshot.error.toString()),
                  ),
                ),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return MyApp();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return MaterialApp(
              home: Scaffold(
                appBar: LazyAppBar(),
                body: Center(
                  child: Text('Make this better'),
                ),
              ),
            );
          },
        );
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
      home: HomePage(),
    );
  }
}
