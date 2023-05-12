import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TripEndingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sharide'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(40),
          color: Colors.black,
          child: Column(
            children: [
            Text(
              'Thank you for using Sharide!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            // Container(
            //   color: Colors.white,
            //   padding: EdgeInsets.all(15),
            //   margin: EdgeInsets.all(15),
            //   child: Column(children: [
            //     Text('Receipt:'),
            //     Text('Total traveled miles: 10 mi'),
            //     Text('Time traveled: 20 mins'),
            //     Text('Total fee: \$4.27'),
            //   ]),
            // ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.push('/driverMain');
              },
              child: Text('Close'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal)),
            )
          ]),
        ));
  }
}
