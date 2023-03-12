import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:moses/generalInfo/homePage.dart';
import 'package:moses/youthGroup/seekersHomePage.dart';
import 'package:moses/documentationInfo/login.dart';
import 'package:moses/generalInfo/ministryLoginSelection.dart';
import 'package:moses/documentationInfo/themeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool needsWeb = Platform.isLinux | Platform.isWindows;
  await Firebase.initializeApp(
    options: needsWeb
        ? DefaultFirebaseOptions.web
        : DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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

          //Unassigned:
          "/login": (context) => const Login(),
        }
    );
  }
}
