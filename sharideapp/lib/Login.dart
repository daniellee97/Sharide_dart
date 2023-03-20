import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:email_validator/email_validator.dart';
//import 'package:regexed_validator/regexed_validator.dart';

import 'TestScreens.dart';
import 'UserScreens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String email = '';

Widget builEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Email',
        style: TextStyle(
            color: Color.fromARGB(255, 239, 238, 238),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(2, 2))
            ]),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
            print(email);
          },
          style: const TextStyle(color: Color.fromARGB(221, 15, 15, 15)),
          decoration: InputDecoration(
            errorText: email == ''
                ? null
                : !email.contains("@")
                    ? "Error: Not a valid email"
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.email,
              color: Color.fromARGB(255, 15, 16, 15),
            ),
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.black38),
          ),
        ),
      )
    ],
  );
}

Widget builPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Password',
        style: TextStyle(
            color: Color.fromARGB(255, 246, 248, 247),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(2, 2))
            ]),
        height: 60,
        child: const TextField(
          obscureText: true,
          style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock,
              color: Color.fromARGB(255, 14, 15, 14),
            ),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.black38),
          ),
        ),
      )
    ],
  );
}

Widget buildForgotPassword() {
  return Container(
    alignment: Alignment.centerRight,
    child: TextButton(
        onPressed: () => print('Forgot Password Pressed'),
        //padding: EdgeInsets.only(right: 0),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )),
  );
}

Widget buildLoginBtn() {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 19, 86, 209),
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          print('Pressed');
        },
        child: const Text('Sign In'),
      ));
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ])),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Welcome to ShareRide \n ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 50),
                      builEmail(),
                      const SizedBox(height: 20),
                      builPassword(),
                      buildForgotPassword(),
                      buildLoginBtn(),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () { 
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyTestingScreen()),
                          );
                        },
                        child: Text('Test provider framework'),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () { 
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyTestingScreen()),
                          );
                        },
                        child: Text('Test main screen'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
