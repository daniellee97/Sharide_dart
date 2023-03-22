import 'package:flutter/material.dart';

import './UserScreens.dart';
import './DriverScreens.dart';

class SignUpForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Sign up form")),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: <Widget> [
            TextFormField(
            decoration: InputDecoration(labelText: 'Your name'),
            keyboardType: TextInputType.emailAddress,
            // validator: (value) {
            //   if (value?.isEmpty || !value?.contains('@')) {
            //     return 'Invalid email!';
            //   }
            // },
            ),
            TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            keyboardType: TextInputType.emailAddress,
            // validator: (value) {
            //   if (value?.isEmpty || !value?.contains('@')) {
            //     return 'Invalid email!';
            //   }
            // },
            ),
            TextFormField(
            decoration: InputDecoration(labelText: 'E-Mail'),
            keyboardType: TextInputType.emailAddress,
            // validator: (value) {
            //   if (value?.isEmpty || !value?.contains('@')) {
            //     return 'Invalid email!';
            //   }
            // },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              // validator: (value) {
              //   if (value.isEmpty || !value.contains('@')) {
              //     return 'Invalid email!';
              //   }
              // },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Default location'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                Navigator.pop(context);
              },
              child: Text('Sign up and go back to log in screen'),
            )
          ]
        ),
      )
    );
  }
}