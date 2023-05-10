import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopupWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Searching for a passenger ...'),
      actions: <Widget>[
        Center(
          child: CircularProgressIndicator(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                context.go('/driverLiveTracking');
              },
            ),
          ],
        ),
      ],
    );
  }
}
