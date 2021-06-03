import 'package:flutter/material.dart';
import 'package:lazy_app/services/firebaseService.dart';
import 'package:lazy_app/widgets/lazyAppBar.dart';
import 'package:lazy_app/widgets/lazyExpansionTile.dart';
import 'package:lazy_app/widgets/lazySwitchTile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
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
