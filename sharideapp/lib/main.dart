import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'AuthenticationScreens.dart';
import './driverSearchingScreen.dart';
import './tripEndingScreen.dart';
import './Login.dart';
import './PaymentScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51MlgzdJ2VkQqns4i5iNV8xZiQaol7ZyCeAgBF5SWjVexVwu0R1Sw89sWQBUVPMvqUIi1jxc2niprcAdCZzL6qqlT00w7DpxfQQ';

  runApp(ProviderScope(
    child: MyApp()
    ));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: UserMainScreen(),
      home: LoginScreen(),
    );
  }
}

