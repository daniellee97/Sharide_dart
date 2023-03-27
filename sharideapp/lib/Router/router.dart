import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_constants.dart';
import '../AuthenticationScreens.dart';
import '../Login.dart';
import '../scheduleScreen.dart';
import '../UserScreens.dart';
import '../driverSearchingScreen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/', 
    builder: (context, state) => LandingScreen(), 
    routes: [
      GoRoute(path: 'login', builder: (context, GoRouterState state) => const LoginScreen()),
      GoRoute(
        path: 'signup',
        builder: (BuildContext context, GoRouterState state) => SignUpForm(),
      ),
      GoRoute(
        path: 'main',
        builder: (BuildContext context, GoRouterState state) => UserMainScreen(),
      ),
      GoRoute(
          path: 'scheduleRide', builder: (BuildContext context, GoRouterState state) => ScheduleScreen()),
      GoRoute(
        path: 'searchDriver',
        builder: (BuildContext context, GoRouterState state) => DriverSearchingScreen(), 
      ),
  ]),
]);
