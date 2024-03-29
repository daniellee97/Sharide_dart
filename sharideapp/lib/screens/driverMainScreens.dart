import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../Providers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sharideapp/DirectionsRepository.dart';
import '../DirectionsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverMainScreen extends ConsumerStatefulWidget {
  const DriverMainScreen({Key? key}) : super(key: key);

  @override
  _DriverMainScreenState createState() => _DriverMainScreenState();
}

class _DriverMainScreenState extends ConsumerState<DriverMainScreen> {
  String dropdownValue = 'Home';
  Future<LatLng> getCoordinates() async {
    var currentLocationNow = ref.watch(currentLocation);
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$currentLocationNow&key=AIzaSyAVBHwy-IOLRqmTKk00_76TRrtcq0HzQ1g'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coordinates = data['results'][0]['geometry']['location'];
      print('There should be the address coordinates $coordinates');
      return LatLng(coordinates['lat'], coordinates['lng']);
    } else {
      throw Exception('Failed to get coordinates');
    }
  }

  Future<LatLng> getDriverCoordinates() async {
    var currentDriverLocationNow = ref.watch(currentDriverLocation);
    print('There is this address for the driver $currentDriverLocationNow');
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$currentDriverLocationNow&key=AIzaSyAVBHwy-IOLRqmTKk00_76TRrtcq0HzQ1g'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coordinates = data['results'][0]['geometry']['location'];
      print('There should be the address coordinates $coordinates');
      return LatLng(coordinates['lat'], coordinates['lng']);
    } else {
      throw Exception('Failed to get coordinates');
    }
  }

  var _initialCameraPosition = CameraPosition(
    target: LatLng(37.3352, -121.8811),
    zoom: 11.5,
  );
  late Directions? _info = Directions(
    bounds: LatLngBounds(
      southwest: LatLng(0, 0),
      northeast: LatLng(0, 0),
    ),
    polylinePoints: [],
    totalDistance: '',
    totalDuration: '',
  );
  late GoogleMapController _googleMapController;
  late Marker? _origin = Marker(
    markerId: MarkerId('origin'),
    position: LatLng(0, 0),
  );
  late Marker? _destination = Marker(
    markerId: MarkerId('destination'),
    position: LatLng(0, 0),
  );
  late Marker? _locationCurrent = Marker(
    markerId: MarkerId('Current Location'),
    position: LatLng(37.335144, -121.8812744),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  );
  late Marker? _locationCurrentPassenger = Marker(
    markerId: MarkerId('locationCurrentPassenger'),
    position: LatLng(0, 0),
    //position: LatLng(37.328880, -121.889794),
  );
  LocationData? currentLocations;
  late double userLocation2Lat = 10;
  late double userLocation2Lng = 10;
  late double driverLocationLat = 100;
  late double driverLocationLng = -100;
  var currentDriverName;
  var currentDriverPlate;
  Set<Marker> _markers = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LocationData? currentLiveLocation;

  void _onMapCreated(GoogleMapController controller) async {
    _googleMapController = controller;
    //var currentLocationNow = ref.watch(currentLocation);
    currentDriverName = ref.watch(driverName);
    final LatLng userLocation2 = await getCoordinates();
    final LatLng driverLocation = await getDriverCoordinates();
    driverLocationLat = driverLocation.latitude;
    driverLocationLng = driverLocation.longitude;
    userLocation2Lat = userLocation2.latitude;
    userLocation2Lng = userLocation2.longitude;
    print('Hey we are doing it here');
    print('Here is the Latitude for Passenger: $userLocation2Lat');
    print('Here is the Longitude for Passenger: $userLocation2Lng');
    print('Here is the Latitude for Driver: $driverLocationLat');
    print('Here is the Longitude for Driver: $driverLocationLng');
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(37.328880, -121.889794),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );
    setState(() {
      markers[MarkerId('place_name')] = marker;
      _markers.add(
        Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(37.7749, -122.4194),
          infoWindow: InfoWindow(title: "My Marker"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
      _locationCurrent = Marker(
        markerId: MarkerId('Current Location'),
        infoWindow: const InfoWindow(title: 'PLEASE'),
        position: LatLng(driverLocationLat, driverLocationLng),
      ); /*
      _locationCurrentPassenger = Marker(
        markerId: const MarkerId('locationCurrentPassenger'),
        infoWindow: const InfoWindow(title: 'CustomerLocation'),
        //position: LatLng(userLocation2Lat, userLocation2Lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );*/
    });
    final directions = await DirectionsRepository()
        .getDirections(origin: userLocation2, destination: driverLocation);

    setState(() => _info = directions!);
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog cannotFindDriverAlert =
        const AlertDialog(title: Text("Cannot find driver"), actions: [
      // okButton,
    ]);
    // get current user name
    var value = ref.watch(userName);

    // get current email
    var _currEmail = ref.watch(email);
    var _currStatus = ref.watch(available);
    var currentDriveLocation = ref.watch(currentDriverLocation);

    String backendURL = ref.watch(authority);
    AlertDialog alert =
        const AlertDialog(title: Text("Wrong login credentials"), actions: [
      // okButton,
    ]);

    // driver status setter
    _setDriverStatusAvailable() async {
      var url = Uri.http(backendURL, '/drivers');
      var url2 = Uri.http(backendURL, '/drivers/avail');
      print("sjsu_email is $_currEmail and current status is $_currStatus");
      print(
          "sjsu_email is $_currEmail and current location is ${ref.read(currentDriverLocation.notifier).state}");
      http.post(url, body: {'sjsu_email': _currEmail, 'avail': 'yes'}).then(
          (response) {
        print("testing");
        print("what here ${response.statusCode}");
        if (response.statusCode == 200) {
          ref.read(available.notifier).state = 'yes';
          print(
              "sjsu_email is $_currEmail and current location is ${ref.read(currentDriverLocation.notifier).state}");
          print(
              "sjsu_email is $_currEmail and currentss status is ${ref.read(available.notifier).state} after changing the status");
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

      http.get(url).then((response) {
        if (response.statusCode == 200) {
          print("We are making some progress now!!!!");
          print(
              "sjsu_email is $_currEmail and currentss location is ${json.decode(response.body)['address']}");
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return cannotFindDriverAlert;
              });
        }
      }).catchError((e) {
        print("What went wrong here for $e");
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello, $value',
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
                    //     ref.read(available.notifier).state = "no";
                    //     ref.read(loggedIn.notifier).state = false;
                    //     ref.read(isDriver.notifier).state = false;
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
                    // const Text(
                    //   'Your home address:',
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    //   textAlign: TextAlign.center,
                    // ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text(
                //       'Your home address:',
                //       style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white),
                //       textAlign: TextAlign.center,
                //     ),
                //     ElevatedButton(
                //       onPressed: () => {},
                //       child: const Text(
                //         'Edit',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.all(Colors.teal)),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // Container(
                //     decoration: const BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(8)),
                //         color: Color(0xFFFEFBE9)),
                //     width: double.infinity,
                //     height: 120,
                //     padding: const EdgeInsets.all(10),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [Text('$currentLocationNow')],
                //     )),
                Container(
                  width: 300,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(driverLocationLat, driverLocationLng),
                        zoom: 11,
                      ),
                      markers: {
                        Marker(
                            markerId: MarkerId('DriverAddress'),
                            infoWindow:
                                const InfoWindow(title: 'DriverLocation'),
                            position:
                                LatLng(driverLocationLat, driverLocationLng),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueViolet)),
                      },
                      cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                          northeast:
                              LatLng(driverLocationLat, driverLocationLng),
                          southwest:
                              LatLng(driverLocationLat, driverLocationLng))),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
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
