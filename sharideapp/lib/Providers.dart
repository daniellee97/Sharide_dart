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

final authority = StateProvider<String>((ref) {
  return "192.168.1.83:3000";
});

// added the available status provider
final available = StateProvider<String>((ref) => "no");

// added the email 
final email = StateProvider<String>((ref) => "test");
