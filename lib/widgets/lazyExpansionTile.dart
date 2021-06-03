import 'package:flutter/material.dart';
import 'package:lazy_app/widgets/lazySwitchTile.dart';

class LazyExpansionTile extends StatelessWidget {
  LazyExpansionTile({
    this.children = const [],
    required this.roomName,
    required this.roomCode,
  });

  final List<Widget> children;
  final String roomName;
  final String roomCode;

  @override
  Widget build(BuildContext context) {
    this.children.add(ListTile(
          title: Text('Settings'),
          leading: Icon(Icons.settings),
        ));
    return ExpansionTile(
      title: Text(this.roomName),
      subtitle: Text(this.roomCode),
      children: this.children,
    );
  }
}
