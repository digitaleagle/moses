import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainAdminScreen extends StatelessWidget {
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
            leading: Icon(Icons.chevron_left),
            title: Text("Go Back Home"),
          ),
          FutureBuilder<String>(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Text("Data: ${snapshot.data}");
                }
                if(snapshot.hasError) {
                  return Text("Error!  ${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
          ),
        ],
      )
    );
  }

  Future<String> getUserInfo() async {
    var uid = FirebaseAuth.instance.currentUser!.uid ?? "<no name>";
    var displayName = FirebaseAuth.instance.currentUser!.displayName ?? "<no name>";
    var userSnapshot = await FirebaseFirestore.instance.collection("user").get();
    var data = userSnapshot.docs;
    return "User ID: $uid\nDisplay: $displayName\n$data";
  }
}
