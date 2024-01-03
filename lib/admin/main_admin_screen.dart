import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  TextEditingController frontMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        //backgroundColor: ThemeColors().primary,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              context.go("/");
            },
            leading: const Icon(Icons.chevron_left),
            title: const Text("Go Back Home"),
          ),
          TextField(
            controller: frontMessageController,
            decoration: const InputDecoration(
              labelText: "Front Page Message",
            ),
          ),
          ElevatedButton(onPressed: () {
            var newValue = <String, String>{"message": frontMessageController.text};
            FirebaseFirestore.instance.collection("font-page").doc("announcements").set(newValue);
          }, child: const Text("Save Front Message")),
          FutureBuilder<String>(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Text("Data: ${snapshot.data}");
                }
                if(snapshot.hasError) {
                  return Text("Error!  ${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
          ),
        ],
      )
    );
  }

  Future<String> getUserInfo() async {
    // Front page message
    final docSnap = await FirebaseFirestore.instance.collection("font-page").doc("announcements").get();
    var frontPageData = docSnap.data();
    if(frontPageData != null) {
      frontMessageController.text = frontPageData["message"];
    }

    // User Experiments
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var displayName = FirebaseAuth.instance.currentUser!.displayName ?? "<no name>";
    var userSnapshot = await FirebaseFirestore.instance.collection("user").get();
    var data = userSnapshot.docs;
    return "User ID: $uid\nDisplay: $displayName\n$data";
  }
}
