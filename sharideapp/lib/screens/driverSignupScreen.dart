import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Form(
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
                  decoration:
                      const InputDecoration(labelText: 'Licence plate number'),
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
