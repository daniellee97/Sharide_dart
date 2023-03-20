import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider1 = StateProvider<String>((ref) { 
  return 'Hello from different file';
  });