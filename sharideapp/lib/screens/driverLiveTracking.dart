import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sharideapp/DirectionsRepository.dart';
import 'package:sharideapp/Providers.dart';
import 'package:sharideapp/screens/paymentScreen.dart';
import '../DirectionsModel.dart';
import 'driverSearchingScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'customerLiveTrackingScreen.dart';
import 'package:location/location.dart';

//const String google_api_key = "AIzaSyC88AJvT4lwQlhR2DdgWILhDbjuH13mtBg";
Future<String> fetchStreetAddress() async {
  //String backendURL = ref.watch(authority);
  //var url = Uri.http(backendURL, '/drivers/avail');
  final response = await http.get(
      Uri.parse('localhost:3000/customers/644be9ae24a5d7c619d637cf/address'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to fetch customer address');
  }
}

class DriverMapScreen extends ConsumerStatefulWidget {
  const DriverMapScreen({Key? key}) : super(key: key);

  @override
  DriverMapScreenState createState() => DriverMapScreenState();
}

class DriverMapScreenState extends ConsumerState<DriverMapScreen> {
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
  late double driverLocationLat = -10;
  late double driverLocationLng = -10;
  var currentDriverName;
  var currentDriverPlate;
  var passengerNames;
  Set<Marker> _markers = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LocationData? currentLiveLocation;

  void getCurrentLiveLocation() async {
    Location location = Location();
    ref.read(driverLocationPing.notifier).state = location;
    var isItWorking = driverLocationPing;
    print("we have made the driver location store here: $location");
    print("we have made the driver locations store here: $isItWorking");
    location.getLocation().then(
      (location) {
        currentLiveLocation = location;
        ref.read(driverCurrentLiveLocation.notifier).state =
            currentLiveLocation;
      },
    );
    //GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLiveLocation = newLoc;
        setState(() {});
      },
    );

    String backendURL = ref.watch(authority);
    var url = Uri.http(backendURL, '/drivers');
    var _currEmail = ref.watch(email);
    http.post(url, body: {
      'sjsu_email': _currEmail,
      'live_latitude': userLocation2Lat,
      'live_longitude': driverLocationLat,
    }).then((response) {
      print("Does this actually work now!?!?!");
      if (response.statusCode == 200) {
        print("I guess this is now going to work");
      }
    }).catchError((e) {
      print('Was not able to get the live coordinates');
    });
  }

  Future<LatLng> getCoordinates() async {
    var currentLocationNow = ref.watch(currentLocation);
    passengerNames = ref.watch(pasengerName);
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$currentLocationNow&key=AIzaSyC88AJvT4lwQlhR2DdgWILhDbjuH13mtBg'));

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
        'https://maps.googleapis.com/maps/api/geocode/json?address=$currentDriverLocationNow&key=AIzaSyC88AJvT4lwQlhR2DdgWILhDbjuH13mtBg'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coordinates = data['results'][0]['geometry']['location'];
      print('There should be the address coordinates $coordinates');
      return LatLng(coordinates['lat'], coordinates['lng']);
    } else {
      throw Exception('Failed to get coordinates');
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    _googleMapController = controller;
    //var currentLocationNow = ref.watch(currentLocation);
    currentDriverName = ref.watch(driverName);
    currentDriverPlate = ref.watch(driverPlate);
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
        position: LatLng(userLocation2Lat, userLocation2Lng),
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

  Future<void> _UpdatePolyLines(LatLng Despos, LatLng Oripos) async {
    //Then here we are getting the directions
    final directions = await DirectionsRepository()
        .getDirections(origin: Oripos, destination: Despos);

    setState(() => _info = directions!);
  }

  void _addMarker(LatLng pos) async {
    var currentLocationNow = ref.watch(currentLocation);
    var userEmail = ref.watch(email);
    final LatLng userLocation = await getCoordinates();
    print(
        'Here we are going to be displaying the current location $userLocation');
    // Call this function wherever you need to retrieve the SJSU email
    //final sjsuEmail = await fetchStreetAddress();
    if (_origin == null || (_origin != null && _destination != null)) {
      //Origin is not set OR Origin/Destination are both set
      //Set Origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('orgin'),
          infoWindow: const InfoWindow(title: 'origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _locationCurrentPassenger = Marker(
          markerId: const MarkerId('locationCurrentPassenger'),
          infoWindow: const InfoWindow(title: 'CustomerLocation'),
          //position: LatLng(userLocation2Lat, userLocation2Lng),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: LatLng(37.328880, -121.889794),
        );
        //Reset Destination
        _destination = null;

        //Reset info
        _info = Directions(
          bounds: LatLngBounds(
            southwest: LatLng(0, 0),
            northeast: LatLng(0, 0),
          ),
          polylinePoints: [],
          totalDistance: '',
          totalDuration: '',
        );
        ;
      });
    } else {
      //Origin is already set
      //Set Destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      //Then here we are getting the directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin!.position, destination: pos);

      setState(() => _info = directions!);
    }
  }

  /*
  void addCurrentLocation() async {
    //var currentLocationNow = ref.watch(currentLocation);
    var userEmail = ref.watch(email);
    final LatLng userLocation = await getCoordinates();
    Location location = Location();
  }
*/
  @override
  void initState() {
    //addCurrentLocation();
    getCurrentLiveLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 25, 0, 255),
        title: Text('Driver Live Tracking'),
        leading: Icon(Icons.arrow_back),
      ),
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 400.0, top: 20.0, left: 12.0, right: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLiveLocation!.latitude!,
                        currentLiveLocation!.longitude!),
                    zoom: 13.5,
                  ),
                  markers: {
                    //markers.values.toSet(),
                    if (_origin != null) _origin!,
                    if (_destination != null) _destination!,
                    Marker(
                      markerId: const MarkerId('CurrentLiveLocation'),
                      position: LatLng(currentLiveLocation!.latitude!,
                          currentLiveLocation!.longitude!),
                    ),
                    Marker(
                        markerId: MarkerId('Here'),
                        infoWindow: const InfoWindow(title: 'CustomerLocation'),
                        position: LatLng(37.3346, -122.0090),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueOrange)),
                    Marker(
                        markerId: MarkerId('DriverAddress'),
                        infoWindow: const InfoWindow(title: 'DriverLocation'),
                        position: LatLng(driverLocationLat, driverLocationLng),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueViolet)),
                  },
                  polylines: {
                    if (_info != null)
                      Polyline(
                        polylineId: const PolylineId('overview_polyine'),
                        color: Colors.blue,
                        width: 5,
                        points: _info!.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList(),
                      )
                  },
                  myLocationButtonEnabled: true,
                  //onLongPress: _addMarker,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              //color: Color.fromARGB(255, 13, 9, 121),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 13, 9, 121),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 50,
              width: 300,
              margin: EdgeInsets.only(top: 100.0),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(_info!.totalDistance,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        _info!.totalDuration,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              //color: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Your Passenger's Info",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Passenger Name: $passengerNames',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    'MAJOR/YEAR',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    'FUN FACT',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    '(Favorite Musics, Game, etc.)',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              height: 220,
              width: 300,
              margin: EdgeInsets.only(left: 16, right: 16, top: 400),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //Do something here with waypoint
                          setState(() {
                            //Here we are just temp setting the updated coords to the
                            //driverlocation can update later to dyncamically change
                            //between going to school or another location
                            driverLocationLat = 37.3352;
                            driverLocationLng = -121.8811;
                            _UpdatePolyLines(
                                LatLng(driverLocationLat, driverLocationLng),
                                LatLng(37.3346, -122.0090));
                          });
                        },
                        child: Text('Picked Up Passenger'),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Button 2'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Center(
                        child: Text(
                          'END RIDE',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    );
  }
}
