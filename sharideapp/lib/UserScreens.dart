import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes/RouteConst.dart';

class UserMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sharide', style: const TextStyle(color: Colors.black),),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            color: Colors.black,
            child: Column(
              children: [
                const Text(
                  'Hello, (Customer Name)',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      'Edit location',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade800)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SecondRoute()),
                      );
                    },
                    child: Text(
                      'Drive history',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade800)),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Your default pick-up location:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text('123 ABC Rd., San Jose, CA 95050')
                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Your current ride schedule:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'March 5th, 2023',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '11:30',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Pick-up at:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '123 ABC Rd., San Jose, CA 95050',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green)),
                                onPressed: () => context.goNamed(RouteConst().scheduleRide),
                                child: Text(
                                  'Schedule a ride',
                                  style: TextStyle(color: Colors.black),
                                )),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.yellow)),
                                onPressed: () => context.goNamed(RouteConst().searchDriver),
                                child: Text(
                                  'Search a driver',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drive history'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Your drive history is as below',
              textDirection: TextDirection.ltr,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to first route when tapped
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            )
          ]
        )
      ),
    );
  }
}