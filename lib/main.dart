import 'package:flutter/material.dart';
import 'homePage.dart';
import 'login.dart';

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
          primarySwatch: Colors.blue,
        ),

        initialRoute: "/login",
        routes: {
          "/homePage": (context) => const HomePage(),
          "/login": (context) => const Login(),
        }
    );
  }
}