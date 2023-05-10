import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final currentLocation = StateProvider<String>((ref) {
  return "1 Washington Sq, San Jose, CA 95112";
});

final currentDriverLocation = StateProvider<String>((ref) {
  return "1401 N Shoreline Blvd, Mountain View, CA 94043";
});

final authority = StateProvider<String>((ref) {
  return "10.0.0.46:3000";
});

// added the available status provider
final available = StateProvider<String>((ref) => "no");

// added the email
final email = StateProvider<String>((ref) => "test");
