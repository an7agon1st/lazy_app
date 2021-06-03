import 'package:flutter/material.dart';

class LazySwitchTile extends StatefulWidget {
  LazySwitchTile(
      {required this.name, required this.deviceCode, required this.fbValue});
  final String name;
  final String deviceCode;
  final bool fbValue;

  @override
  _LazySwitchTileState createState() => _LazySwitchTileState();
}

class _LazySwitchTileState extends State<LazySwitchTile> {
  bool value = false;

  @override
  void initState() {
    this.value = widget.fbValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.name),
      subtitle: Text(widget.deviceCode),
      value: this.value,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
      },
    );
  }
}
