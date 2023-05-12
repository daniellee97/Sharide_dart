import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../Providers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverMainScreen extends ConsumerStatefulWidget {
  const DriverMainScreen({Key? key}) : super(key: key);

  @override
  _DriverMainScreenState createState() => _DriverMainScreenState();
}

class _DriverMainScreenState extends ConsumerState<DriverMainScreen> {
  String dropdownValue = 'Home';
  @override
  Widget build(BuildContext context) {
    // get current user name
    var value = ref.watch(userName);

    // get current email
    var _currEmail = ref.watch(email);
    var _currStatus = ref.watch(available);

    String backendURL = ref.watch(authority);
    AlertDialog alert =
        const AlertDialog(title: Text("Wrong login credentials"), actions: [
      // okButton,
    ]);

    // driver status setter
    _setDriverStatusAvailable() async {
      var url = Uri.http(backendURL, '/drivers');
      print("sjsu_email is $_currEmail and current status is $_currStatus");
      http.post(url, body: {'sjsu_email': _currEmail, 'avail': 'yes'}).then(
          (response) {
        print("testing");
        print("what here ${response.statusCode}");
        if (response.statusCode == 200) {
          ref.read(available.notifier).state = 'yes';
          print(
              "sjsu_email is $_currEmail and current status is ${ref.read(available.notifier).state} after changing the status");
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              });
        }
      }).catchError((e) {
        print("Offline for user $e");
      });
    }

    _setDriverStatusUnavailable() async {
      var url = Uri.http(backendURL, '/drivers');
      print("sjsu_email is $_currEmail and current status is $_currStatus");
      http.post(url, body: {'sjsu_email': _currEmail, 'avail': 'no'}).then(
          (response) {
        print("testing");
        print("what here ${response.statusCode}");
        if (response.statusCode == 200) {
          ref.read(available.notifier).state = 'no';
          print(
              "sjsu_email is $_currEmail and current status is ${ref.read(available.notifier).state} after changing the status");
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              });
        }
      }).catchError((e) {
        print("Offline for user $e");
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sharide'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: const EdgeInsets.all(40),
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $value',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        _setDriverStatusUnavailable();
                        ref.read(available.notifier).state = "no";
                        ref.read(loggedIn.notifier).state = false;
                        ref.read(isDriver.notifier).state = false;
                        ref.read(userName.notifier).state = "";
                      },
                      child: const Text(
                        'Log out',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your home address:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xFFFEFBE9)),
                    width: double.infinity,
                    height: 120,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [Text('123 ABC Rd., San Jose, CA 95050')],
                    )),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(height: 160),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              dropdownColor: Colors.teal,
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Home',
                                'Campus',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.teal)),
                                onPressed: () {
                                  _setDriverStatusAvailable();
                                  context.push('/popupwindow');
                                },
                                child: const Text(
                                  'Go online',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class SecondRoute extends ConsumerWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drive history'),
      ),
      body: Center(
          child: Column(children: [
        const Text(
          'Your drive history is as below',
          textDirection: TextDirection.ltr,
        ),
        ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        )
      ])),
    );
  }
}
