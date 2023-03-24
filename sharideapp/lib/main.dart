import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

import './AuthenticationScreens.dart';
import './driverSearchingScreen.dart';
import './tripEndingScreen.dart';
import './Login.dart';
import './PaymentScreen.dart';
import './UserScreens.dart';
import './scheduleScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51MlgzdJ2VkQqns4i5iNV8xZiQaol7ZyCeAgBF5SWjVexVwu0R1Sw89sWQBUVPMvqUIi1jxc2niprcAdCZzL6qqlT00w7DpxfQQ';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
      );

  final GoRouter _router = GoRouter(routes: <GoRoute>[
    GoRoute(
      routes: <GoRoute>[
        GoRoute(
          path: 'logIn',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: 'signUp',
          builder: (context, state) => SignUpForm(),
        ),
        GoRoute(
          path: 'main',
          builder: (context, state) => UserMainScreen(),
        ),
        GoRoute(
          path: 'scheduleRide', 
          builder: (context, state) => ScheduleScreen()
        ),
        GoRoute(
          path: 'searchDriver',
          builder: (context, state) => DriverSearchingScreen(),
        ),
      ], path: '/', builder: (context, state) => LandingScreen()
    ),
  ]);
}
