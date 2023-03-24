import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sharide')),
        body: Container(
            padding: EdgeInsets.all(15),
            color: Colors.black,
            child: Column(children: [
              const Text(
                'Hello, log in as',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 15),
                      child: ElevatedButton(
                        onPressed: () => context.go('/logIn'),
                        child: Text(
                          'Driver',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue.shade800)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 15),
                      child: ElevatedButton(
                        onPressed: () => context.go('/logIn'),
                        child: Text(
                          'Passenger',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue.shade800)),
                      ),
                    ),
                  ]),
              const Text(
                'Or you can sign up below',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 15),
                      child: ElevatedButton(
                        onPressed: () => context.go('/signUp'),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue.shade800)),
                      ),
                    ),
                  ]),
            ])));
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Sign up form")),
        body: Container(
          padding: EdgeInsets.all(15),
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(children: <Widget>[
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
          ]),
        ));
  }
}
