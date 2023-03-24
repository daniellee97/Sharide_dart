import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DriverSearchingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sharide'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text('Searching for a driver ... ',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () => context.pop(),
                child: Text('Cancel'),
              ),
            ],
          ),
        ));
  }
}
