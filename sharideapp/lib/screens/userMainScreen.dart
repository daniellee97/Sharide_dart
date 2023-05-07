import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../Providers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserMainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUserName = ref.watch(userName);
    var userEmail = ref.watch(email);

    String backendURL = ref.watch(authority);

    AlertDialog foundDriverAlert = const AlertDialog(
      title: Text("Found driver! Click on next step to start ride"),
    );

    AlertDialog cannotFindDriverAlert =
        const AlertDialog(title: Text("Cannot find driver"), actions: [
      // okButton,
    ]);

    AlertDialog startsDrive =
        const AlertDialog(title: Text("Ride started"), actions: []);

    AlertDialog cannotStartsDrive = const AlertDialog(
        title: Text("Cannot starts ride, no trip processing"), actions: []);

    _findDriver() async {
      var url = Uri.http(backendURL, '/drivers/avail');
      http.get(url).then((response) {
        // print("what here $response.statusCode");
        if (response.statusCode == 200) {
          // create a trip processing here
          var urlTripProcessing = Uri.http(backendURL, '/tripProcessing');

          var driver_email = json.decode(response.body)["sjsu_email"];

          var body = {
            'customer_email': userEmail,
            'driver_email': driver_email,
          };

          http.put(urlTripProcessing, body: body).then((response) {
            // print("what here $response.statusCode");
            if (response.statusCode == 200) {
            } else {
              // print('No trip processing created yet');
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return cannotStartsDrive;
                  });
            }
          }).catchError((e) {
            print("Offline for user $e");
          });

          // end creating a trip processing

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return foundDriverAlert;
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return cannotFindDriverAlert;
              });
        }
      }).catchError((e) {
        print("Offline for user $e");
      });
    }

    _startsRideForPassenger() async {
      var url = Uri.http(backendURL, '/tripProcessing/forCustomer');

      // print("user email is $userEmail");
      var body = {
        'customer_email': userEmail,
      };

      http.post(url, body: body).then((response) {
        // print("what here $response.statusCode");
        if (response.statusCode == 200) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return startsDrive;
              });
        } else {
          // print('No trip processing created yet');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return cannotStartsDrive;
              });
        }
      }).catchError((e) {
        print("Offline for user $e");
      });
    }

    _deleteAnyTripProcessing() async {
      var url = Uri.http(backendURL, '/tripProcessing/forCustomer');

      // print("user email is $userEmail");
      var body = {
        'customer_email': userEmail,
      };

      http.delete(url, body: body).then((response) {
        // print("what here $response.statusCode");
        if (response.statusCode == 200) {
        } else {}
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
                      'Hello, $currentUserName',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // ElevatedButton(
                    //   style: ButtonStyle(
                    //       backgroundColor:
                    //           MaterialStateProperty.all(Colors.red)),
                    //   onPressed: () {
                    //     _deleteAnyTripProcessing();
                    //     ref.read(loggedIn.notifier).state = false;
                    //     ref.read(userName.notifier).state = "";
                    //   },
                    //   child: const Text(
                    //     'Log out',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // )
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
                      children: const [
                        Text('123 ABC Rd., San Jose, CA 95050')
                      ],
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
                              value: 'Home',
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
                                if (newValue == 'Home' ||
                                    newValue == 'Campus') {
                                  context.push('/scheduleRide');
                                }
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
                                  _findDriver();
                                  context.push('/searchDriver');
                                },
                                child: const Text(
                                  'Search a driver',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.teal)),
                                onPressed: () {
                                  _startsRideForPassenger();
                                },
                                child: const Text(
                                  'Start ride',
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
