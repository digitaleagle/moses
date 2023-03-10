import 'package:flutter/material.dart';
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
        title: const Text('Landmark Baptist Church'),
        actions: <Widget> [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset('assets/images/lbc_logo_outlined.png')
          )
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0,1],
                  colors: [
                    const Color.fromRGBO(111, 233, 17, 0),
                    ThemeColors().secondary,
                  ]
                )
              ),
                child: Image.asset('assets/images/lbc_title.png')
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('Visitor Information'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Services and Events'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Ministries and Organization Information'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login to your Ministry'),
              onTap: () {
                Navigator.pushNamed(context, '/ministryLoginSelection');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Landmark Baptist Church'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Back'),
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
                      height: width * 0.15 + 5,
                      width: width * 0.90 + 5, //90% width
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: ThemeColors().secondary),
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(          //1:6 ratio
                        height: width * 0.15,   //15% width
                        width: width * 0.90,    //90% width
                        child: Image.asset( //Image is temporarily hardcoded.
                          'assets/images/visitor_portal_cover.png'
                        )
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