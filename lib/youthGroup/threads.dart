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
  TextEditingController message = TextEditingController();

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
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        //For now, the list of message threads is hardcoded.
                        return Align(
                          alignment: index.isEven ? Alignment.topLeft: Alignment.topRight,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: (width-20)*0.667),
                            child: SizedBox(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  color: index.isOdd ? sentColor: receivedColor,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    messages[index].message,
                                    textAlign: index.isEven ? TextAlign.left: TextAlign.right,
                                    style: TextStyle(color: index.isEven ? Colors.black: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: messages.length,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: width-20,
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: TextField(
                                  onSubmitted: (value) {
                                    if(value.isNotEmpty) {
                                      sendText(messages, threadID);
                                    }
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  //cursorColor: theme,
                                  decoration: InputDecoration(
                                    //iconColor: theme,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                                    //floatingLabelStyle: TextStyle(color: theme),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      //borderSide: BorderSide(color: theme!),
                                    ),
                                    labelText: 'Text message',
                                  ),
                                  controller: message,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if(message.text.isNotEmpty) {
                                              sendText(messages, threadID);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: sentColor,
                                            shape: const CircleBorder()
                                          ),
                                          child: const SizedBox()
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: IconButton(
                                        icon: const Icon(Icons.send, color: Colors.white,),
                                        onPressed: () {
                                          if(message.text.isNotEmpty) {
                                            sendText(messages, threadID);
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    )
                  )
                ],
              ),
            );
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
    );
  }

  void sendText(List<Message> messages, int index) async {
    //ASK DAD HOW TO READ USERNAME FOR "FROM" PROPERTY
    Message newMessage = Message('user', message.text);
    messages.add(newMessage);
    List<Map<String, String>> allMessages = [];
    for(Message text in messages) {
      Map<String, String> tempText = {'from': text.from, 'message': text.message};
      allMessages.add(tempText);
    }

    final docSnap = await _db.collection("seekers").doc("messaging").get();
    var data = docSnap.data();
    data!['threads'][index]['messages'] = allMessages;
    FirebaseFirestore.instance.collection("seekers").doc("messaging").set(data);
    message.text = '';
    setState(() {});
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