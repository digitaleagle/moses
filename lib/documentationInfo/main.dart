import 'package:flutter/material.dart';
import 'package:moses/generalInfo/homePage.dart';
import 'login.dart';
import 'package:moses/generalInfo/ministryLoginSelection.dart';
import 'themeData.dart';

void main() async {
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
          "/homePage": (context) => const HomePage(),
          "/login": (context) => const Login(),
          "/ministryLoginSelection": (context) => const MinistryLoginSelection(),
        }
    );
  }
}