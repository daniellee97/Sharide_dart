import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './Providers.dart';

class DriverMainScreen extends ConsumerWidget {

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        var value = ref.watch(userName);
        return Scaffold(
            appBar: AppBar(title: Text('Hello, $value')),
            body: Container(
                padding: EdgeInsets.all(15),
                color: Colors.black,
                child: Column(
                    children: [
                        Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 15),
                            child: ElevatedButton(
                                        onPressed: () => {
                                            
                                        },
                                        child: Text(
                                        'Edit location',
                                        style: TextStyle(color: Colors.black),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors.blue.shade800)),
                            ),
                        ),

                        const Text(
                        'Your default location is: \n123 ABC Rd, San Jose, CA 95050 ',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        ),

                        const Text(
                        'Your current ride schedule',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        ),

                        const Text(
                        "November 28, 2022 \n 11:30 AM \n Pick up passenger at: 123 XYZ rd, San Jose Ca 95050",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        ),
                        ElevatedButton(
                              onPressed: () {
                                ref.read(loggedIn.notifier).state = false;
                                ref.read(isDriver.notifier).state = false;
                                ref.read(userName.notifier).state = "";
                              }, 
                              child: const Text(
                                  'Log out',
                                  style: TextStyle(color: Colors.black),
                                ),
                        )
                    ]
                )
            )
        );
    }
}
