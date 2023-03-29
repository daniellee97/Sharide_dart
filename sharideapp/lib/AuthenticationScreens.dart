import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharideapp/Login.dart';

import 'Providers.dart';

class WelcomeScreen extends ConsumerWidget {
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

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String? _email;
  String? _password;
  String? _name;
  String? _userName;
  String? _defaultLocation;

  void _validateEmail() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() {
      _email = _emailController.text;
    });
  }

  void _goback() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up form")),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(15),
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Your name'),
                //keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                //keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your user name';
                  }
                  return null;
                },
                onSaved: (value) => _userName = value,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.endsWith('@sjsu.edu')) {
                    return 'Only SJSU email addresses are allowed!';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                //keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                obscureText: true,
                onSaved: (value) => _password = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Default location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your default location';
                  }
                  return null;
                },
                onSaved: (value) => _defaultLocation = value,
              ),
              ElevatedButton(
                onPressed: () {
                  // call both functions here
                  _validateEmail();
                  _goback();
                },
                //onPressed: _validateEmail,
                child: const Text('Sign up and go back to log in screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
