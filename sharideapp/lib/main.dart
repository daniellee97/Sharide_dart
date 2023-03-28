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

  // app router
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              LandingScreen(),
          routes: [
            GoRoute(
                path: 'login',
                builder: (BuildContext context, GoRouterState state) =>
                    const LoginScreen()),
            GoRoute(
              path: 'signup',
              builder: (BuildContext context, GoRouterState state) =>
                  SignUpForm(),
            ),
            GoRoute(
              path: 'main',
              builder: (BuildContext context, GoRouterState state) =>
                  UserMainScreen(),
            ),
            GoRoute(
                path: 'scheduleRide',
                builder: (BuildContext context, GoRouterState state) =>
                    ScheduleScreen()),
            GoRoute(
              path: 'searchDriver',
              builder: (BuildContext context, GoRouterState state) =>
                  DriverSearchingScreen(),
            ),
          ]),
    ],
  );

  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sharide',
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}
