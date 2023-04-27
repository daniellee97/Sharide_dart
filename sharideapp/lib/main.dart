import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharideapp/screens/passengerSearchingScreen.dart';

import 'Providers.dart';

import 'screens/loginScreen.dart';
import 'screens/driverMainScreens.dart';
import 'screens/userMainScreen.dart';
import 'screens/passengerSignupScreen.dart';
import 'screens/scheduleScreen.dart';
import 'screens/driverSearchingScreen.dart';
import 'screens/landingScreen.dart';
import 'screens/driverSignupScreen.dart';
import 'screens/popupScreenDriver.dart';
import 'screens/popupScreenPassenger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51MlgzdJ2VkQqns4i5iNV8xZiQaol7ZyCeAgBF5SWjVexVwu0R1Sw89sWQBUVPMvqUIi1jxc2niprcAdCZzL6qqlT00w7DpxfQQ';

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    bool loggedInYet = ref.watch(loggedIn);
    bool isCurrentUserDriver = ref.watch(isDriver);

    // go router
    GoRouter _router = GoRouter(
      initialLocation: loggedInYet
          ? isCurrentUserDriver
              ? '/driverMain'
              : '/userMain'
          : '/',
      routes: <GoRoute>[
        GoRoute(
          name: 'landing',
          path: '/',
          builder: (context, state) => LandingScreen(),
          routes: <GoRoute>[
            GoRoute(
              name: 'login',
              path: 'login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              name: 'passengerSignup',
              path: 'passengerSignup',
              builder: (context, state) => SignUpForm(),
            ),
            GoRoute(
              name: 'driverSignup',
              path: 'driverSignup',
              builder: (context, state) => SignUpFormDriver(),
            ),
            GoRoute(
              name: 'userMain',
              path: 'userMain',
              builder: (context, state) => UserMainScreen(),
            ),
            GoRoute(
              name: 'scheduelRide',
              path: 'scheduleRide',
              builder: (context, state) => ScheduleScreen(),
            ),
            GoRoute(
              name: 'searchDriver',
              path: 'searchDriver',
              builder: (context, state) => DriverSearchingScreen(),
            ),
            GoRoute(
              name: 'driverMain',
              path: 'driverMain',
              builder: (context, state) => DriverMainScreen(),
            ),
            GoRoute(
                name: 'searchPassenger',
                path: 'searchPassenger',
                builder: (context, state) => PassengerSearchingScreen()),
            GoRoute(
                name: 'popupwindow',
                path: 'popupwindow',
                builder: (context, state) => PopupWindow()),
            GoRoute(
                name: 'popupwindowPassenger',
                path: 'popupwindowPassenger',
                builder: (context, state) => PopupWindowPassenger()),
          ],
        )
      ],
    );

    return MaterialApp.router(
      title: 'Sharide',
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
        primarySwatch: Colors.teal,
      ),
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      // home: UserMainScreen(),
      // home: loggedInYet
      //     ? isCurrentUserDriver
      //         ? DriverMainScreen()
      //         : UserMainScreen()
      //     : WelcomeScreen(),
      // home: loggedInYet ? UserMainScreen() : const LoginScreen(),
    );
  }
}
