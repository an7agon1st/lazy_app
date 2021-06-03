import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LazySwitchTile extends StatefulWidget {
  LazySwitchTile({
    required this.name,
    required this.deviceCode,
  });
  final String name;
  final String deviceCode;

  @override
  _LazySwitchTileState createState() => _LazySwitchTileState();
}

class _LazySwitchTileState extends State<LazySwitchTile> {
  bool value = false;

  late DatabaseReference _dbRef;
  late StreamSubscription<Event> _dbSubscription;

  @override
  void initState() {
    // TODO: BOX NUMBER from shared prefs
    _dbRef = FirebaseDatabase.instance.reference().child('020221/LR/' + widget.deviceCode);
    _dbRef.keepSynced(true);
    _dbSubscription = _dbRef.onValue.listen((Event event) {
      setState(() {
        value = event.snapshot.value ?? false;
      });
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      setState(() {
        this.value = !this.value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.name),
      subtitle: Text(widget.deviceCode),
      value: this.value,
      onChanged: (value) async {
        setState(() {
          this.value = value;
        });
        await changeVal(this.value);
      },
    );
  }

  Future<void> changeVal(bool value) async {
    // Increment counter in transaction.
    final TransactionResult? transactionResult =
        await _dbRef.runTransaction((MutableData mutableData) async {
      mutableData.value = value;
      print('ran txn');
      return mutableData;
    });
  }
}
