import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/src/state.dart';
import 'package:moses/documentationInfo/themeData.dart';

import 'documentation.dart';

class Threads extends StatefulWidget {
  GoRouterState state;
  Threads(this.state, {Key? key}) : super(key: key);

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
    int threadID = int.parse(widget.state.pathParameters["threadID"] ?? '0');

    return FutureBuilder<ThreadInfo>(
        future: loadFirebaseThreads(threadID),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Scaffold(body: Center(child: Text("Error: ${snapshot.error}")));
          }
          if(snapshot.hasData && snapshot.data != null) {
            List<Message> messages = snapshot.data!.message;
            Color sentColor = const Color.fromRGBO(11, 97, 208, 100);
            Color receivedColor = const Color.fromRGBO(239, 243, 250, 100);
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data!.name),
                backgroundColor: ThemeColors().seekersTheme,
                actions: <Widget> [
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset('assets/images/seekers_logo.png')
                  )
                ],
              ),
              body: ListView.builder(
                itemBuilder: (_, index) {
                  //For now, the list of message threads is hardcoded.
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                      index.isEven ? 0: width*0.333,
                      0,
                      index.isEven ? width*0.333: 0,
                      10
                    ),
                    child: SizedBox(
                      width: width*0.667,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isOdd ? sentColor: receivedColor,
                        ),
                        child: Text(
                          messages[index].message,
                          textAlign: index.isEven ? TextAlign.left: TextAlign.right,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: messages.length,
              ),
            );
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
    );
  }

  Future<ThreadInfo> loadFirebaseThreads(int index) async {
    // Used the read section from https://firebase.google.com/docs/firestore/quickstart#dart
    // Another good resource: https://www.youtube.com/watch?v=DqJ_KjFzL9I
    final docSnap = await _db.collection("seekers").doc("messaging").get();
    var data = docSnap.data();
    var newThread = data!['threads'][index];
    List<Message> tempMessages = [];
    for(var message in newThread['messages']) {
      Message newMessage = Message(
        message['from'],
        message['message']
      );
      tempMessages.add(newMessage);
    }
    ThreadInfo output = ThreadInfo(
      newThread['name'],
      newThread['description'],
      tempMessages
    );
    return output;
  }
}

class ThreadInfo {
  String name;
  String description;
  List<Message> message;
  ThreadInfo(this.name, this.description, this.message);
}