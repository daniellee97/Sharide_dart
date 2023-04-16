import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../Providers.dart';
import 'package:http/http.dart' as http;

class PassengerSearchingScreen extends ConsumerStatefulWidget {
  const PassengerSearchingScreen({Key? key}) : super(key: key);

  @override
  _PassengerSearchingScreenState createState() => _PassengerSearchingScreenState();

}

class _PassengerSearchingScreenState extends ConsumerState<PassengerSearchingScreen> {


  @override
  Widget build(BuildContext context) {
    String backendURL = ref.watch(authority);
    var _currEmail = ref.watch(email);
    var _currStatus = ref.watch(available);

    _setDriverStatusUnavailable() async {
       var url = Uri.http(backendURL, '/drivers');
      http.post(url, body: {'sjsu_email': _currEmail, 'avail': 'no'}).then((response) {
        print("testing");
        print("what here $response.statusCode");
        if(response.statusCode == 200) {
          ref.read(available.notifier).state = 'no';
          print("sjsu_email is $_currEmail and current status is ${ref.read(available.notifier).state}");
        } else {
          print('cannot change driver\'s status');
        }
      }).catchError((e) {
         print("Offline for user $e");
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sharide'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text('Searching for a passenger ...',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const Center(
                child: CircularProgressIndicator(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  _setDriverStatusUnavailable();
                  context.pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ));
  }
}
