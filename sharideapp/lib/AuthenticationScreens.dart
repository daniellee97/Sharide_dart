import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

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
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () => context.push('/signup'),
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

class SignUpFormDriver extends StatefulWidget {
  @override
  _DriverSignUpFormState createState() => _DriverSignUpFormState();
}

class _DriverSignUpFormState extends State<SignUpFormDriver> {
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _vehicleYearController = TextEditingController();
  final TextEditingController _vehicleMakeController = TextEditingController();
  final TextEditingController _licenceController = TextEditingController();
  // final TextEditingController _vehicleModelController = TextEditingController();

  String? _name;
  String? _email;
  String? _password;
  int? _vehicleYear;
  String? _vehicleMake;
  String? _licence;
  // String? _vehicleModel;

  //Sign up page for driver( vehicle year, make, model, plate number)

  void _validateEmail() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() {
      _name = _nameController.text;
      _email = _emailController.text;
      _password = _passwordController.text;
      _vehicleYear = int.tryParse(_vehicleYearController.text);
      _vehicleMake = _vehicleMakeController.text;
      // _vehicleModel = _vehicleModelController.text;
      _licence = _licenceController.text;
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

   void _signUpDriver() {
    // String? _name;
  // String? _email;
  // String? _password;
  // int? _vehicleYear;
  // String? _vehicleMake;
  // String? _licence;
  // String? _vehicleModel;

    var body = {
      'license_no': _licence,
      'name': _name,
      'sjsu_email': _email,
      'password': _password,
      'vehicleYear': _vehicleYear.toString(),
      'vehicleMake': _vehicleMake,
    
    };

    print("name $_name and email $_email and password $_password and year $_vehicleYear and make $_vehicleMake and licence $_licence and model ");
    
    String authority = "192.168.1.83:3000";
    var url = Uri.http(authority, '/drivers');

    http.put(url, body: body).then((response) {
        if(response.statusCode == 200) {
          // showDialog(context: context, builder: (BuildContext context) {
          //   return showSignUpSuccessfully;}
          // );
          showDialog(context: context, builder: (BuildContext context) {
            return showSignUpSuccessfully;}
          );
        } else {
          // showDialog(context: context, builder: (BuildContext context) {
          //   return showSignUpUnsuccessfully;}
          // );
          showDialog(context: context, builder: (BuildContext context) {
            return showSignUpUnsuccessfully;}
          );
        }
      }).catchError((e) {
        print("Error $e");
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
                controller: _vehicleMakeController,
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
                controller: _vehicleYearController,
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
                controller: _licenceController,
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
              ElevatedButton(
                onPressed: () {
                  // call both functions here
                  _validateEmail();
                  _signUpDriver();
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
