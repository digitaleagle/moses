import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moses/themeData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: ThemeColors().primary,
        actions: <Widget> [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset('assets/images/lbc_logo.png')
          )
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(
              decoration: BoxDecoration(color: ThemeColors().primary),
                child: Text('DRAWER')
            ),
            ListTile(
              title: Text('Page 1'),
            ),
            ListTile(
              title: Text('Page 2'),
            ),
            ListTile(
              title: Text('Page 3'),
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Close'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ListView(
            children: <Widget> [
              Stack(
                alignment: Alignment.center,
                children: [
                  Card(
                    child: SizedBox(
                      height: 155,
                      width: width - 115,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: ThemeColors().secondary),
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 150,
                        width: width - 120,
                        child: Stack(
                          children: <Widget> [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                                child: Text(
                                  'Are you a visitor?',
                                  style: GoogleFonts.gotu(
                                    textStyle: const TextStyle(fontSize: 25)
                                  )
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 75, 0, 0),
                                child: Text(
                                  'Learn more about Landmark Baptist Church here.',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}