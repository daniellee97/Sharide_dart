import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharideapp/Login.dart';

import 'Providers.dart';

class WelcomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Please log in')),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
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
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpForm()),
                          )
                        },
                        child: Text(
                          'Sign up as Passenger',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 41, 54, 238))),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpFormDriver()),
                          )
                        },
                        child: Text(
                          'Sign up as Driver',
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

class SignUpFormDriver extends StatefulWidget {
  @override
  _DriverSignUpFormState createState() => _DriverSignUpFormState();
}

class _DriverSignUpFormState extends State<SignUpFormDriver> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String? _name;
  String? _email;
  String? _password;
  int? _vehicleYear;
  String? _vehicleMake;
  String? _licence;
  String? _vehicleModel;

  //Sign up page for driver( vehicle year, make, model, plate number)

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
                decoration: const InputDecoration(labelText: 'Vehicle-Make'),
                //keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Vehicle name';
                  }
                  return null;
                },
                onSaved: (value) => _vehicleMake = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Vehicle-Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Vehicle-Year';
                  }
                  return null;
                },
                onSaved: (value) => _vehicleYear = value as int?,
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Licence plate number'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Licence plate number';
                  }
                  return null;
                },
                onSaved: (value) => _licence = value,
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
