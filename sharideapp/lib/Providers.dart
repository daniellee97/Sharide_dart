import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

final helloWorldProvider1 = StateProvider<String>((ref) {
  return 'Hello from different file';
});

final loggedIn = StateProvider<bool>((ref) {
  return false;
});

final isDriver = StateProvider<bool>((ref) {
  return false;
});

final userName = StateProvider<String>((ref) {
  return "curredddntUserName";
});

final driverName = StateProvider<String>((ref) {
  return "Choosens Driver";
});

final pasengerName = StateProvider<String>((ref) {
  return "Rando Pass";
});

final driverPlate = StateProvider<String>((ref) {
  return "1233456";
});

final currentLocation = StateProvider<String>((ref) {
  return "1 Washington Sq, San Jose, CA 95112";
});

final currentDriverLocation = StateProvider<String>((ref) {
  return "1401 N Shoreline Blvd, Mountain View, CA 94043";
});

final authority = StateProvider<String>((ref) {
  return "10.250.41.176:3000";
});

final driverLatitude = StateProvider<String>((ref) {
  return "100";
});

final driverCurrentLiveLocation = StateProvider<LocationData?>((ref) {
  print("WE ARE TRYING THIS");
  return null;
});

final driverLocationPing = StateProvider<Location>((ref) {
  return Location();
});

// added the available status provider
final available = StateProvider<String>((ref) => "no");

// added the email
final email = StateProvider<String>((ref) => "test");

class LocationProvider extends ChangeNotifier {
  LocationData? _currentLiveLocation;
  LocationData? get currentLiveLocation => _currentLiveLocation;

  void updateCurrentLiveLocation(LocationData locationData) {
    _currentLiveLocation = locationData;
    notifyListeners();
  }
}
