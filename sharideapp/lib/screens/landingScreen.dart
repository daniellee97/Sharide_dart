import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharideapp/screens/loginScreen.dart';

import '../Providers.dart';

class LandingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Welcome to Sharide'), centerTitle: true,),
        body: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.black,
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20.0), // Set the vertical padding to 10
                child: Text(
                  'SHARIDE',
                  style: TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 41, 54, 238)),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 60.0), // Set the top padding to 10
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 200, // set the fixed width of the button
                    child: ElevatedButton(
                      onPressed: () => context.push('/login'),
                      child: Text(
                        'Log in',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 238, 241, 245),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 200.0), // Set the top padding to 10
                child: Text(
                  'If you don\'t have an account, please Sign up',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        onPressed: () => context.push('/signup'),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 41, 54, 238))),
                      ),
                    ),
                  ]),
            ])));
  }
}