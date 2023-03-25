import 'package:flutter/material.dart';

import './UserScreens.dart';
import './DriverScreens.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Please log in')),
        body: Container(
            padding: EdgeInsets.all(15),
            color: Colors.black,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 60.0), // Set the vertical padding to 10
                child: Text(
                  'SHARIDE',
                  style: TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 41, 54, 238)),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 60.0), // Set the top padding to 10
                child: Text(
                  'Log in as',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
                              builder: (context) => DriverMainScreen()),
                        );
                      },
                      child: Text(
                        'Driver',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 238, 241, 245),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200, // set the fixed width of the button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserMainScreen()),
                        );
                      },
                      child: Text(
                        'Passenger',
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
              Padding(
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
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpForm()),
                          )
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 41, 54, 238))),
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

  late String _email;

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
          padding: EdgeInsets.all(15),
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Your name'),
                //keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                //keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.endsWith('@sjsu.edu')) {
                    return 'Only SJSU email addresses are allowed!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                //keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Default location'),
              ),
              ElevatedButton(
                onPressed: () {
                  // call both functions here
                  _validateEmail();
                  _goback();
                },
                //onPressed: _validateEmail,
                child: Text('Sign up and go back to log in screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
