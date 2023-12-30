import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moses/documentationInfo/themeData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseFirestore _db;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //Load list of advertisements from database.

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
          //Set to ListView.builder and load list of adds from database.
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
              ),
              Card(
                child: SizedBox(
                  height: width * 0.15,   //15% width
                  width: width * 0.90,    //90% width
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<String>(
                        future: loadFirebaseMessage(),
                        builder: (context, snapshot) {
                          if(snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          }
                          if(snapshot.hasData) {
                            return Text(snapshot.data ?? "");
                          }
                          return const CircularProgressIndicator();
                        },
                    ),
                    //  From what I understand, the .snapshot() and using the
                    //    StreamBuilder would allow you to accept updates, and would
                    //    be better for data that you want to change often.
                    // child: StreamBuilder<QuerySnapshot>(
                    //   stream: FirebaseFirestore.instance.collection("font-page").snapshots(),
                    //   builder: (context, snapshop) {
                    //     if(!snapshop.hasData) return LinearProgressIndicator();
                    //     return Text(snapshop.data!.docs.first.data().toString());
                    //   },
                    // )
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Future<String> loadFirebaseMessage() async {
    // Used the read section from https://firebase.google.com/docs/firestore/quickstart#dart
    // Another good resource: https://www.youtube.com/watch?v=DqJ_KjFzL9I

    // Note: this was supposed to say "front-page", but I mistyped it.  You can't rename, so I
    //       won't worry about fixing it for now.
    final docSnap = await _db.collection("font-page").doc("announcements").get();
    var data = docSnap.data();
    if(data == null) {
      return "??";
    } else {
      return data!["message"];
    }
  }

  @override
  void initState() {
    // from https://firebase.google.com/docs/firestore/quickstart#dart
    //  I really don't need this.  I could just use this in the loadFirebaseMessage() function
    _db = FirebaseFirestore.instance;
  }
}