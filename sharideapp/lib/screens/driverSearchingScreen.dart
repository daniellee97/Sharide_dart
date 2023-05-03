import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './driverLiveTracking.dart';
import '../Providers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng> getCoordinates(String address) async {
  final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyC88AJvT4lwQlhR2DdgWILhDbjuH13mtBg'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final coordinates = data['results'][0]['geometry']['location'];
    return LatLng(coordinates['lat'], coordinates['lng']);
  } else {
    throw Exception('Failed to get coordinates');
  }
}

class DriverSearchingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      // Go to the new page after 5 seconds
      context.go('/customerLiveTracking');
    });
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
              const Text('Searching for a driver ... ',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Center(
                child: CircularProgressIndicator(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ));
  }
}
