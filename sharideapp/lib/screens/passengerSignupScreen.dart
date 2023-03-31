import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AlertDialog showSignUpSuccessfully = const AlertDialog(
            title: Text("Sign up successfully, please go back and log in"),
            actions:[
              // okButton,
            ]
  );

  AlertDialog showSignUpUnsuccessfully = const AlertDialog(
            title: Text("Sign up unsuccessfully"),
            actions:[
              // okButton,
            ]
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _defaultLocationController = TextEditingController();

  String? _email;
  String? _password;
  String? _name;
  String? _defaultLocation;

  void _validateEmail() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() {
      _email = _emailController.text;
      _password = _passwordController.text;
      _name = _nameController.text;
      _defaultLocation = _defaultLocationController.text;
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

  void _signUpPassenger() {
    var body = {
      'sjsu_email': _email,
      'password': _password,
      'address': _defaultLocation,
      'name': _name,
    
    };

    String authority = "192.168.1.83:3000";
    var url = Uri.http(authority, '/customers');

    http.put(url, body: body).then((response) {
        if(response.statusCode == 200) {
          showDialog(context: context, builder: (BuildContext context) {
            return showSignUpSuccessfully;}
          );
        } else {
          showDialog(context: context, builder: (BuildContext context) {
            return showSignUpUnsuccessfully;}
          );
        }
      }).catchError((e) {
        print("Error");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign up form")),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(15),
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
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
                controller: _passwordController,
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
                controller: _defaultLocationController,
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
                  _signUpPassenger();
                },
                //onPressed: _validateEmail,
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}