import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moses/documentationInfo/themeData.dart';

import 'documentation.dart';

class Threads extends StatefulWidget {
  const Threads({Key? key}) : super(key: key);

  @override
  State<Threads> createState() => _ThreadsState();
}

class _ThreadsState extends State<Threads> {

  late FirebaseFirestore _db;
  @override
  void initState() {
    // from https://firebase.google.com/docs/firestore/quickstart#dart
    //  I really don't need this.  I could just use this in the loadFirebaseMessage() function
    _db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //List is temporarily hardcoded.
    //List needs to load list of message threads from database.
    List testList = [1,2,3];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seekers'),
        backgroundColor: ThemeColors().seekersTheme,
        actions: <Widget> [
          Container(
              padding: const EdgeInsets.all(5),
              child: Image.asset('assets/images/seekers_logo.png')
          )
        ],
      ),

      body: FutureBuilder<List<ThreadIndicator>>(
          future: loadFirebaseThreads(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            if(snapshot.hasData && snapshot.data != null) {
              return Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        //For now, the list of message threads is hardcoded.
                        return ListTile(
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].description),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  )
              );
            }
            return const CircularProgressIndicator();
          }
      ),
    );
  }

  Future<List<ThreadIndicator>> loadFirebaseThreads() async {
    // Used the read section from https://firebase.google.com/docs/firestore/quickstart#dart
    // Another good resource: https://www.youtube.com/watch?v=DqJ_KjFzL9I

    // Note: this was supposed to say "front-page", but I mistyped it.  You can't rename, so I
    //       won't worry about fixing it for now.
    final docSnap = await _db.collection("seekers").doc("messaging").get();
    var data = docSnap.data();
    List<ThreadIndicator> output = [];
    for(int i = 0; i < data!['threads'].length; i++) {
      ThreadIndicator newThreadIndicator = ThreadIndicator(
        data['threads'][i]['name'],
        data['threads'][i]['description'],
      );
      output.add(newThreadIndicator);
    }
    return output;
  }
}

class ThreadIndicator {
  String name;
  String description;
  ThreadIndicator(this.name, this.description);
}