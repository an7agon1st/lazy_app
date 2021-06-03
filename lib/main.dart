import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_app/widgets/lazyExpansionTile.dart';
import 'package:lazy_app/widgets/lazySwitchTile.dart';

void main() {
  runApp(MyApp());
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "LazyApp",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 10.0, fontFamily: 'Agne', color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    stopPauseOnTap: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'A reason to not get off your ass'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
