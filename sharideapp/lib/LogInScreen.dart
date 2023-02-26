import 'package:flutter/material.dart';

import './UserScreens.dart';

class LogInScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('Please log in')),
            body: Container(
                padding: EdgeInsets.all(15),
                color: Colors.black,
                child: Column(
                    children: [
                        const Text('Hello, log in as',
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
                                'Driver',
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
                                    MaterialPageRoute(builder: (context) => UserMainScreen()),
                                );
                                },
                                child: Text(
                                'Passenger',
                                style: TextStyle(color: Colors.black),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue.shade800)),
                            ),
                        ),
                    ]

                )
            )
        );
    }
}