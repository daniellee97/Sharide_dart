import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _logInAsPassenger() async {
      // print('Email: $_email');
      // print('Password: $_password');
      // print('Test');
      // one example student: sampleStudent@sjsu.edu, samplePassword
      

      String authority = "192.168.1.83:3000";
      var url = Uri.http(authority, '/customers/logIn');
      http.post(url, body: {'sjsu_email': _email, 'password': _password}).then((response) {
        if(response.statusCode == 200) {
          // print("Log in successfully");
          ref.read(loggedIn.notifier).state = true;
          var temp = json.decode(response.body)['name'];
          ref.read(userName.notifier).state = temp;
          Navigator.pop(context);
        } else {
          // print("Error log in");
        }
      }).catchError((e) {
        // print("Offline");
      });

    }

    _logInAsDriver() async {
      // one example driver: sampleDriver@sjsu.edu, sampleDriver
      String authority = "192.168.1.83:3000";
      var url = Uri.http(authority, '/drivers/logIn');
      http.post(url, body: {'sjsu_email': _email, 'password': _password}).then((response) {
        if(response.statusCode == 200) {
          ref.read(loggedIn.notifier).state = true;
          ref.read(isDriver.notifier).state = true;
          var temp = json.decode(response.body)['name'];
          ref.read(userName.notifier).state = temp;
          Navigator.pop(context);
        } else {
          print("Error log in");
        }
      }).catchError((e) {
        print("Offline");
      });

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        //color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Welcome to ShaRide',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 48, 47, 47),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.endsWith('@sjsu.edu')) {
                          return 'Only SJSU email addresses are allowed';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Do something with the email and password
                          _logInAsDriver();

                        }
                      },
                      child: const Text('Login as Driver'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Do something with the email and password
                          _logInAsPassenger();

                          // start loging in as Passenger

                        }
                      },
                      child: const Text('Login as Passenger'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

