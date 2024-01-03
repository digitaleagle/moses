import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'package:moses/generalInfo/homePage.dart';
import 'package:moses/youthGroup/seekersHomePage.dart';
import 'package:moses/documentationInfo/login.dart';
import 'package:moses/generalInfo/ministryLoginSelection.dart';
import 'package:moses/documentationInfo/themeData.dart';
import 'youthGroup/messaging.dart';
import 'youthGroup/threads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool needsWeb = Platform.isLinux | Platform.isWindows;
  await Firebase.initializeApp(
    options: needsWeb
        ? DefaultFirebaseOptions.web
        : DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyNewGoRouterApp());
}

class MyNewGoRouterApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(routes: [
        //General Information:
        GoRoute(
          path: "/",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: "/homePage",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: "/ministryLoginSelection",
          builder: (context, state) => const MinistryLoginSelection(),
        ),
        //Youth Group:
        GoRoute(
          path: "/seekersHomePage",
          builder: (context, state) => const SeekersHomePage(),
        ),
        GoRoute(
          path: "/seekersMessaging",
          builder: (context, state) => const SeekersMessaging(),
        ),
        GoRoute(
          path: "/threads",
          builder: (context, state) => const Threads(),
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) => const Login(),
        ),
      ]),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Moses',
        theme: ThemeData(
          primarySwatch: ThemeColors().primary,
        ),

        initialRoute: "/homePage",
        routes: {
          //General Information:
          "/homePage": (context) => const HomePage(),
          "/ministryLoginSelection": (context) => const MinistryLoginSelection(),

          //Youth Group:
          "/seekersHomePage": (context) => const SeekersHomePage(),
          "/seekersMessaging": (context) => const SeekersMessaging(),
          "/threads": (context) => const Threads(),

          //Unassigned:
          "/login": (context) => const Login(),
        }
    );
  }
}
