import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:sharideapp/Providers.dart';

class SignUpFormDriver extends ConsumerStatefulWidget {
  @override
  _DriverSignUpFormState createState() => _DriverSignUpFormState();
}

class _DriverSignUpFormState extends ConsumerState<SignUpFormDriver> {
  AlertDialog showSignUpSuccessfully = const AlertDialog(
      title: Text("Sign up successfully, please go back and log in"),
      actions: [
        // okButton,
      ]);

  AlertDialog showSignUpUnsuccessfully =
      const AlertDialog(title: Text("Sign up unsuccessfully"), actions: [
    // okButton,
  ]);

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
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    String backendURL = ref.watch(authority);
    
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

    // print(
    //     "name $_name and email $_email and password $_password and year $_vehicleYear and make $_vehicleMake and licence $_licence and model ");

    var url = Uri.http(backendURL, 'drivers');

    http.put(url, body: body).then((response) {
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return showSignUpSuccessfully;
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return showSignUpUnsuccessfully;
            });
      }
    }).catchError((e) {
      print("Error $e");
    });
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                  child: const Text('Complete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
