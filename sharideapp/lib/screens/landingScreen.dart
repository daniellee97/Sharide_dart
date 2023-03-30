import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 140),
        color: Colors.black,
        child: SingleChildScrollView(
            child: Column(
              children: [
          const Text(
            'SHARIDE',
            style: TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 41, 54, 238),
            ),
          ), 
          const SizedBox(height: 250),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              onPressed: () => context.push('/login'),
              child: Text(
                'Log in',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            'If you don\'t have an account, please sign up',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              onPressed: () => context.push('/signup'),
              child: Text(
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                'Sign up',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 41, 54, 238)),
              ),
            ),
          )
        ])),
    ));
  }
}
